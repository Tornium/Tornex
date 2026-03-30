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
  A registry for `Tornex.SpecQuery` backed by a tree held by a globally registered `GenServer`.

  This module will store each `Tornex.SpecQuery` and map the query to its `Tornex.Scheduler.Bucket`
  to allow for the combination of queries. This only applies to `Tornex.SpecQuery` that are not quarantined.
  """

  @typedoc """
  The state for the `GenServer` of the tree representing pending, un-fulfilled API calls.

  ## Example Tree
  ```
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
  ```
  """
  @type state :: %{
          String.t() => %{
            (Tornex.SpecQuery.parameter() | nil) => %{
              String.t() => [Tornex.SpecQuery.t()]
            }
          }
        }

  use GenServer
  require Logger

  @doc """
  Start the `Tornex.Scheduler.QueryRegistry` GenServer.
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: {:global, __MODULE__})
  end

  @doc """
  Insert a `Tornex.SpecQuery` into the query tree.

  The `Tornex.SpecQuery` must be registered against an origin (of type `Genserver.from()`) so that the
  `Tornex.Scheduler.ExecutionUnit` generated including the `Tornex.SpecQuery` will be able to return the
  portion of the response corresponding to the `Tornex.SpecQuery` to the origin.
  """
  @spec insert(query :: Tornex.SpecQuery.t()) :: :ok
  def insert(%Tornex.SpecQuery{origin: origin} = query) when not is_nil(origin) do
    GenServer.call({:global, __MODULE__}, {:insert, query})
  end

  # We need to have a fallback for Tornex.Query for the Tornex.Bucket to prevent the bucket from crashing
  # instead of splitting the logic in Tornex.Bucket.
  def insert(%Tornex.Query{} = _query), do: :ok

  @doc """
  Merge any applicable `Tornex.SpecQuery` for this combintion of a resource and resource ID together.
  """
  @spec merge(query :: Tornex.SpecQuery.t()) :: Tornex.Scheduler.ExecutionUnit.t() | Tornex.SpecQuery.t()
  def merge(%Tornex.SpecQuery{quarantine?: true} = query) do
    # If the query is quarantined, we should skip this and let the Bucket handle this query normally.
    query
  end

  def merge(%Tornex.SpecQuery{} = query) do
    try do
      GenServer.call({:global, __MODULE__}, {:merge, query})
    rescue
      e ->
        Logger.error(Exception.format(:error, e, __STACKTRACE__))
        query
    end
  end

  # We need to have a fallback for Tornex.Query for the Tornex.Bucket to prevent the bucket from crashing
  # instead of splitting the logic in Tornex.Bucket.
  def merge(%Tornex.Query{} = query), do: query

  @impl GenServer
  def init(_opts \\ []) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call(
        {:insert, %Tornex.SpecQuery{origin: origin} = query},
        _from,
        %{} = state
      )
      when not is_nil(origin) do
    resource = Tornex.SpecQuery.resource!(query)
    resource_id = Tornex.SpecQuery.resource_id!(query)
    selections = Tornex.SpecQuery.selections!(query)

    # We need to ensure that there is the resource + resource ID in the structure of the tree
    # before we can add the selections and queries to it.
    modified_state =
      state
      |> update_in([resource], &(&1 || %{}))
      |> update_in([resource, resource_id], &(&1 || %{}))

    # We need to build the tree out to add any missing nodes and to add the new query.
    # If the query is a duplicate of an existing query, we can skip it.
    new_state =
      Enum.reduce(selections, modified_state, fn selection, state_acc ->
        update_in(state_acc, [resource, resource_id, selection], fn
          nil ->
            # Path in the tree does not exist and we must create it.
            [query]

          query_list when is_list(query_list) and query_list != [] ->
            [query | query_list] |> Enum.uniq()
        end)
      end)

    {:reply, :ok, new_state}
  end

  @impl GenServer
  def handle_call(
        {:merge, %Tornex.SpecQuery{quarantine?: false, origin: origin, key_owner: query_key_owner} = query},
        _from,
        %{} = state
      )
      when not is_nil(origin) do
    # We need to find similar queries to combine with this query. Any similar queries will need to be
    # marked as being handled by something else. The task handling this query needs to respond to all
    # queries waiting on this query. This MUST be blocking to avoid responding to a `from` twice. As
    # such, this should respond as fast as possible to avoid blocking buckets and this GenServer
    # for too long.

    unit =
      case merge_similar(query, state) do
        %Tornex.Scheduler.ExecutionUnit{} = execution_unit ->
          # We want to remove the parents of the execution unit. The query that started this merge is not
          # guaranteed to be in the queue of the parent's bucket, but Bucket.pop should silently ignore
          # queries not in the bucket's queue. We should skip queries originating from the bucket of the
          # original query as to not create a deadlock when this GenServer is waiting on that Bucket to pop
          # the query and that Bucket is waiting on this GenServer to merge the queries.
          execution_unit.parents
          |> Enum.reject(fn %Tornex.SpecQuery{key_owner: parent_key_owner} -> parent_key_owner == query_key_owner end)
          |> Enum.each(fn %Tornex.SpecQuery{} = query ->
            Task.start(Tornex.Scheduler.Bucket.pop!(query))
          end)

          execution_unit

        %Tornex.SpecQuery{} = ^query ->
          query
      end

    # After the queries are merged, we'll want to drop the unused branches of the state tree to
    # minimize memory usage.
    {:reply, unit, remove(state, unit)}
  end

  @doc """
  Merge "similar" queries to the `Tornex.SpecQuery` provided to create one query containing as many
  selections as possible. Quarantined queries will not be merged and will be executed as provided.

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
  @spec merge_similar(query :: Tornex.SpecQuery.t(), state :: state()) ::
          Tornex.Scheduler.ExecutionUnit.t() | Tornex.SpecQuery.t()
  def merge_similar(%Tornex.SpecQuery{quarantine?: false} = query, state) when is_map(state) do
    resource = Tornex.SpecQuery.resource!(query)
    resource_id = Tornex.SpecQuery.resource_id!(query)

    # We need to find all queries that have a matching resource and resource ID. This is the bare minimum
    # for matching queries but will substantially reduce potential matches.
    overlapping_resource_id =
      state
      |> get_in([resource, resource_id])
      |> then(&(&1 || %{}))

    overlapping_queries =
      overlapping_resource_id
      |> Enum.flat_map(fn {_selection, queries} -> queries end)
      |> then(&[query | &1])
      |> Enum.uniq()

    do_merge_similar(overlapping_queries, query)
  end

  @spec do_merge_similar(overlapping_queries :: [Tornex.SpecQuery.t()], query :: Tornex.SpecQuery.t()) ::
          Tornex.Scheduler.ExecutionUnit.t() | Tornex.SpecQuery.t()
  defp do_merge_similar([%Tornex.SpecQuery{} = query] = _overlapping_queries, %Tornex.SpecQuery{} = query) do
    # When there is only one applicable query sharing a resource + resource ID, we can just short-circuit the merging
    # and return this query as there are no similar queries. For simplicity's sake, and to minimize issues, we will
    # return this as a `SpecQuery` instead of an `ExecutionUnit`.
    query
  end

  defp do_merge_similar(overlapping_queries, %Tornex.SpecQuery{} = original_query)
       when is_list(overlapping_queries) and overlapping_queries != [] do
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
    execution_units =
      overlapping_queries
      |> filter_parameter_collisions()
      |> Enum.map(fn subset -> accumulate_queries(subset, public_paths, non_public_paths, original_query) end)
      |> Enum.reject(&is_nil/1)

    case execution_units do
      [] ->
        # Fallback: no mergeable subsets; return an ExecutionUnit that at least contains the original query.
        accumulate_queries([original_query], public_paths, non_public_paths, original_query)

      units ->
        Enum.max_by(units, fn %Tornex.Scheduler.ExecutionUnit{paths: paths} -> length(paths) end)
    end
  end

  @spec accumulate_queries(
          queries_subset :: [Tornex.SpecQuery.t()],
          public_paths :: [module()],
          non_public_paths :: [module()],
          query :: Tornex.SpecQuery.t()
        ) :: Tornex.Scheduler.ExecutionUnit.t() | nil
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

    cond do
      non_public_queries == [] and only_public_queries != [] ->
        # If there is no non-public query, we should merge all similar public queries into a single SpecQuery.
        Enum.reduce(only_public_queries, Tornex.Scheduler.ExecutionUnit.new(), &Tornex.Scheduler.ExecutionUnit.merge/2)

      non_public_queries != [] and only_public_queries != [] ->
        # If there is a non-public query, we can first merge all similar non-public queries into the SpecQuery before
        # merging all the similar public queries into the query.
        query_acc =
          Enum.reduce(non_public_queries, Tornex.Scheduler.ExecutionUnit.new(), &Tornex.Scheduler.ExecutionUnit.merge/2)

        Enum.reduce(only_public_queries, query_acc, &Tornex.Scheduler.ExecutionUnit.merge/2)

      non_public_queries != [] and only_public_queries == [] ->
        # If there is a non-public query, we can first merge all similar non-public queries into the SpecQuery before
        # merging all the similar public queries into the query.
        Enum.reduce(non_public_queries, Tornex.Scheduler.ExecutionUnit.new(), &Tornex.Scheduler.ExecutionUnit.merge/2)

      non_public_queries == [] and only_public_queries == [] ->
        nil
    end
  end

  @spec filter_parameter_collisions(queries :: [Tornex.SpecQuery.t()]) :: [[Tornex.SpecQuery.t()]]
  defp filter_parameter_collisions([%Tornex.SpecQuery{} = query]) do
    # We should short-circuit this function to reduce the latency of this hot-path of the GenServer. Since there is only
    # one query, we can just return that one query.
    query
  end

  defp filter_parameter_collisions(queries) when is_list(queries) do
    # To filter conflicting parameters, we want to want to find the set of queries with the largest number of unique paths
    # where the set of queries does not have any parameters with equal keys and differing values.

    queries
    |> greedy_subsets()
    |> Enum.sort_by(&count_unique_paths/1, :desc)
    |> Enum.reject(fn subset when is_list(subset) -> subset == [] end)
  end

  @typedoc false
  @type conflict_map :: %{Tornex.SpecQuery.t() => MapSet.t(Tornex.SpecQuery.t())}

  @spec conflict_graph(queries :: [Tornex.SpecQuery.t()]) :: conflict_map()
  defp conflict_graph(queries) when is_list(queries) do
    # We want to build a lookup table of the queries that will conflict with other queries to avoid
    # excessive recomputation. Since we're building all valid subsets, this is better performance-wise.

    queries
    |> Enum.map(fn %Tornex.SpecQuery{} = query_one ->
      queries
      |> Enum.filter(fn %Tornex.SpecQuery{} = query_two ->
        query_one != query_two and not conflict_free?([query_one, query_two])
      end)
      |> MapSet.new()
      |> then(&{query_one, &1})
    end)
    |> Map.new()
  end

  # TODO: test this
  @doc """
  Greedily build subsets of the queries where the subsets of queries' parameters do not conflict.
  """
  @spec greedy_subsets(queries :: [Tornex.SpecQuery.t()]) :: [[Tornex.SpecQuery.t()]]
  def greedy_subsets(queries) when is_list(queries) do
    # TODO: convert this from building permutations to combinations such that order does not matter
    conflict_graph = conflict_graph(queries)

    Enum.map(queries, fn start_node ->
      build_subset(start_node, Enum.reject(queries, &(&1 == start_node)), conflict_graph)
    end)
  end

  @spec build_subset(
          start_node :: Tornex.SpecQuery.t(),
          queries :: [Tornex.SpecQuery.t()],
          conflict_graph :: conflict_map()
        ) :: [Tornex.SpecQuery.t()]
  defp build_subset(%Tornex.SpecQuery{} = start_node, queries, conflict_graph)
       when is_list(queries) and is_map(conflict_graph) do
    Enum.reduce(queries, [start_node], fn %Tornex.SpecQuery{} = query, acc ->
      if Enum.any?(acc, &MapSet.member?(conflict_graph[&1], query)) do
        acc
      else
        [query | acc]
      end
    end)
  end

  @doc """
  Determine if a list of `Tornex.SpecQuery` is "conflict free".

  For the list of queries to be "conflict free", all of the queries must have one unique value for
  each parameter key-value pair.
  """
  @spec conflict_free?(queries :: [Tornex.SpecQuery.t()]) :: boolean()
  def conflict_free?([%Tornex.SpecQuery{} = query_one, %Tornex.SpecQuery{} = query_two] = _queries) do
    # We want to provide a faster case to use in `conflict_graph/1`
    not Enum.any?(query_one.parameters, fn {parameter_key, parameter_value} ->
      case Enum.find(query_two.parameters, fn {k, _v} -> k == parameter_key end) do
        nil ->
          false

        {^parameter_key, other_parameter_value} ->
          other_parameter_value != parameter_value
      end
    end)
  end

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

  @doc """
  Traverse the state tree and remove the branches that are being fulfilled by the
  `Tornex.Scheduler.ExecutionUnit`.

  After removing the queries being fulfilled from the branches of the state tree, the function will
  also prune the tree of any branches related to the queries if there are no queries retaining them.
  """
  @spec remove(state :: state(), execution_unit :: Tornex.Scheduler.ExecutionUnit.t() | Tornex.SpecQuery.t()) :: state()
  def remove(
        state,
        %Tornex.Scheduler.ExecutionUnit{
          parents: [%Tornex.SpecQuery{} = first_parent | _] = parents
        } = execution_unit
      )
      when is_map(state) do
    resource = Tornex.SpecQuery.resource!(first_parent)
    resource_id = Tornex.SpecQuery.resource_id!(first_parent)

    selections =
      execution_unit
      |> Map.get(:parents)
      |> Enum.flat_map(&Tornex.SpecQuery.selections!/1)
      |> Enum.uniq()

    # We want to remove the queries from the branch of the resource + resource_id. If there are no leafs
    # remaining on the outermost branch (resource + resource_id), we should prune the branch as much as
    # possible to reduce memory consumption.
    selections
    |> Enum.reduce(state, fn selection, acc ->
      acc
      |> update_in([resource, resource_id, selection], fn
        nil ->
          nil

        queries when is_list(queries) ->
          Enum.reject(queries, &Enum.member?(parents, &1))
      end)
      |> prune_path([resource, resource_id, selection])
    end)
    |> prune_path([resource, resource_id])
    |> prune_path([resource])
  end

  def remove(state, %Tornex.SpecQuery{} = query) when is_map(state) do
    resource = Tornex.SpecQuery.resource!(query)
    resource_id = Tornex.SpecQuery.resource_id!(query)
    selections = Tornex.SpecQuery.selections!(query)

    selections
    |> Enum.reduce(state, fn selection, acc ->
      acc
      |> update_in([resource, resource_id, selection], fn
        nil ->
          nil

        queries when is_list(queries) ->
          Enum.reject(queries, &(&1 == query))
      end)
      |> prune_path([resource, resource_id, selection])
    end)
    |> prune_path([resource, resource_id])
    |> prune_path([resource])
  end

  @spec prune_path(state :: state(), path :: [term()]) :: map()
  defp prune_path(state, path) when is_map(state) and is_list(path) do
    case get_in(state, path) do
      [] ->
        pop_in(state, path) |> elem(1)

      child when is_map(child) and map_size(child) == 0 ->
        pop_in(state, path) |> elem(1)

      nil ->
        pop_in(state, path) |> elem(1)

      _ ->
        state
    end
  end
end
