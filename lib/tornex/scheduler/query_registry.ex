# Copyright 2024-2025 tiksan
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule Tornex.Scheduler.QueryRegistry do
  @moduledoc """
  A registry for `SpecQuery` backed by a tree held by a globally registered GenServer.

  This module will store each `SpecQuery` and map the query to its `Tornex.Supervisor.Bucket` to allow for 
  the combination of queries.

  ## Example Tree
  user
  ├─ 2383326
  │  ├─ profile
  │  ├─ attacks
  ├─ 1
  faction
  ├─ 15644
  │  ├─ attacks
  torn
  ├─ nil
  │  ├─ crimes
  │  ├─ items
  """

  use GenServer
  import Bitwise

  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: {:global, __MODULE__})
  end

  @doc """
  Insert a `SpecQuery` into the query tree.
  """
  @spec insert(query :: Tornex.SpecQuery.t()) :: :ok
  def insert(%Tornex.SpecQuery{} = query) do
    GenServer.call({:global, __MODULE__}, {:insert, query})
  end

  @impl GenServer
  def init(_opts \\ []) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:insert, %Tornex.SpecQuery{} = query}, _from, %{} = state) do
    resource = Tornex.SpecQuery.resource!(query)
    resource_id = Tornex.SpecQuery.resource_id!(query)
    selections = Tornex.SpecQuery.selections!(query)

    # We need to build the tree out to add any missing nodes and to add the new query.
    # If the query is a duplicate of an existing query, we can skip it.
    new_state =
      Enum.reduce(selections, state, fn selection, state_acc ->
        state_acc
        |> update_in([resource], &(&1 || %{}))
        |> update_in([resource, resource_id], &(&1 || %{}))
        |> update_in([resource, resource_id, selection], fn
          nil ->
            # Path in the tree does not exist and we must create it.
            [query]

          query_list ->
            query_list = query_list || []
            [query | query_list] |> Enum.uniq()
        end)
      end)

    # TODO: Determine the response value
    {:reply, :ok, new_state}
  end

  # TODO: Something needs to track what queries will respond for other queries and send the data received
  # from that query to the others.

  # TODO: There needs to be a way to enqueue quarantined requests that won't be inserted into the query tree

  @impl GenServer
  def handle_call({:call, %Tornex.SpecQuery{} = query}, _from, %{} = state) do
    # We need to find similar queries to combine with this query. Any similar queries will need to be
    # marked as being handled by something else. The task handling this query needs to respond to all
    # queries waiting on this query.
    #
    # NOTE: It does not necessarily need to be the query passed into this function invocation that the
    # queries are merged into. We should prefer to merge it into a query from the resource owner if
    # possible to ensure extended data is returned. If there a similar query that cannot be merged, those
    # should be separated into a different query.
  end

  @doc """
  Merge "similar" queries to the `Tornex.SpecQuery` provided to create one query containing as many
  selections as possible.

  **NOTE:** The queries may not necessarily be merged into the query provided if it is more efficient to
  merge the queries into a different non-public query.

  For a query to be similar to another query, the query must:
    1) Be for the same resource and resource ID.
    2) Not have conflicting parameters where the same key has different values.
    3) Not be different responses depending on the invoker. For example, this can occur when the responses
    is specific to a resource owner (such as a user for `user/basic` when not providing a user to
    `user/{id}/basic`).
    4) Not have an additional permission required such as faction API access.
  """
  @spec merge_similar(query :: Tornex.SpecQuery.t(), state :: map()) :: Tornex.SpecQuery.t()
  def merge_similar(%Tornex.SpecQuery{} = query, state) when is_map(state) do
    resource = Tornex.SpecQuery.resource!(query)
    resource_id = Tornex.SpecQuery.resource_id!(query)
    # selections = Tornex.SpecQuery.selections!(query)

    # We need to find all queries that have a matching resource and resource ID. This is the bare minimum
    # for matching queries but will substantially reduce potential matches.
    overlapping_resource_id =
      state
      |> get_in([resource, resource_id])
      |> then(&(&1 || %{}))

    overlapping_queries =
      overlapping_resource_id
      |> Enum.flat_map(fn {_selection, queries} -> queries end)
      |> Enum.uniq()

    # For a query to be eligible to merged:
    #  - There must not be conflicting parameters: Conflicting parameters may cause incorrect information to
    #    be returned in the API call response.
    #  - There must not be differing responses depending on the invoker.
    #  - The queries must not require an additional in-game permission such as faction API access. This can be ensuring
    #    the minimum API key is a public key.

    # Only the following can be merged:
    #  - public queries into a public query
    #  - public queries into a non-public query
    #  - non-public queries into a non-public query
    # Merging a non-public query into a public query will either result in private information leak or an API error depending
    # on the permissions the key owner has. As this is not known, we can only assume that the key owner making non-public
    # queries has the necessary permissions and the key owner making public queries does not have the necessary permissions.

    {public_paths, non_public_paths} =
      overlapping_queries
      |> Enum.flat_map(fn %Tornex.SpecQuery{paths: paths} -> paths end)
      |> Enum.uniq()
      |> Enum.split_with(&Tornex.Spec.path_module_public?/1)

    # To filter conflicting parameters and paths, we want to want to find the subset of queries with the largest number of
    # unique paths where the subset of queries does not have any parameters with equal keys and differing values and no other
    # paths conflict.
    overlapping_queries
    |> filter_parameter_collisions()
    |> Enum.map(fn subset -> accumulate_queries(subset, public_paths, non_public_paths, query) end)
    |> Enum.reject(&is_nil/1)
    |> Enum.max_by(fn %Tornex.SpecQuery{paths: paths} -> length(paths) end)
  end

  @spec accumulate_queries(
          queries_subset :: [Tornex.SpecQuery.t()],
          public_paths :: [module()],
          non_public_paths :: [module()],
          query :: Tornex.SpecQuery.t()
        ) :: Tornex.SpecQuery.t() | nil
  defp accumulate_queries(
         queries_subset,
         public_paths,
         non_public_paths,
         %Tornex.SpecQuery{key_owner: original_query_key_owner} = _query
       )
       when is_list(queries_subset) and is_list(public_paths) and is_list(non_public_paths) do
    # We can merge the public and non-public queries by first merging non-public queries into a SpecQuery with non-public queries.
    # If there is that SpecQuery with non-public queries, we can merge all public into it. Otherwise, all public queries should be
    # merged into a SpecQUery with only public queries.

    non_public_queries =
      Enum.filter(queries_subset, fn %Tornex.SpecQuery{paths: query_paths, key_owner: query_key_owner} ->
        original_query_key_owner == query_key_owner and
          Enum.any?(query_paths, fn path -> Enum.member?(non_public_paths, path) end)
      end)

    only_public_queries =
      Enum.filter(queries_subset, fn %Tornex.SpecQuery{paths: query_paths} ->
        Enum.all?(query_paths, fn path -> Enum.member?(public_paths, path) end)
      end)

    accumulated_queries =
      cond do
        non_public_queries == [] and only_public_queries != [] ->
          # If there is no non-public query, we should merge all similar public queries into a single SpecQuery.
          Enum.reduce(only_public_queries, Enum.fetch!(only_public_queries, 0), &Tornex.SpecQuery.merge/2)

        non_public_queries != [] and only_public_queries != [] ->
          # If there is a non-public query, we can first merge all similar non-public queries into the SpecQuery before
          # merging all the similar public queries into the query.
          query_acc = Enum.reduce(non_public_queries, Enum.fetch!(non_public_queries, 0), &Tornex.SpecQuery.merge/2)
          Enum.reduce(only_public_queries, query_acc, &Tornex.SpecQuery.merge/2)

        non_public_queries != [] and only_public_queries == [] ->
          # If there is a non-public query, we can first merge all similar non-public queries into the SpecQuery before
          # merging all the similar public queries into the query.
          Enum.reduce(non_public_queries, Enum.fetch!(non_public_queries, 0), &Tornex.SpecQuery.merge/2)

        non_public_queries == [] and only_public_queries == [] ->
          nil
      end

    accumulated_queries
  end

  @spec filter_parameter_collisions(queries :: [Tornex.SpecQuery.t()]) :: [[Tornex.SpecQuery.t()]]
  defp filter_parameter_collisions(queries) when is_list(queries) do
    # To filter conflicting parameters, we want to want to find the set of queries with the largest number of unique paths
    # where the set of queries does not have any parameters with equal keys and differing values.

    queries
    |> all_subsets()
    |> Enum.filter(&conflict_free?/1)
    |> Enum.sort_by(&count_unique_paths/1, :desc)
    |> Enum.reject(fn subset -> subset == [] end)
  end

  @doc """
  Generate a list of all possible subsets of the combinations of queries.
  """
  @spec all_subsets(queries :: [Tornex.SpecQuery.t()]) :: [[Tornex.SpecQuery.t()]]
  def all_subsets(queries) when is_list(queries) do
    count = length(queries)
    maximum = :math.pow(2, count) |> round()

    for mask <- 0..(maximum - 1) do
      for {element, bit} <- Enum.zip(queries, 0..(count - 1)), (mask &&& 1 <<< bit) != 0, do: element
    end
  end

  @doc """
  Determine if a list of queries is "conflict free".

  For the list of queries to be "conflict free", all of the queries must have one unique value for
  each parameter key-value pair.
  """
  @spec conflict_free?(queries :: [Tornex.SpecQuery.t()]) :: boolean()
  def conflict_free?(queries) do
    queries
    |> Enum.flat_map(& &1.parameters)
    |> Enum.group_by(fn {key, _value} -> key end)
    |> Enum.all?(fn {_key, pairs} ->
      pairs
      |> Enum.map(fn {_key, value} -> value end)
      |> Enum.uniq()
      |> length() == 1
    end)
  end

  @doc """
  Get the number of unique paths in a list of queries.
  """
  @spec count_unique_paths(queries :: [Tornex.SpecQuery.t()]) :: non_neg_integer()
  def count_unique_paths(queries) when is_list(queries) do
    queries
    |> Enum.flat_map(& &1.paths)
    |> Enum.uniq()
    |> length()
  end
end
