defmodule Tornex.Scheduler.ExecutionUnit do
  @moduledoc """
  An execution unit for the API used by the scheduler to fan out combined queries.

  Given a set of parent `Tornex.SpecQuery` from the `Tornex.Scheduler.QueryRegistry` with the same resource and
  resource ID (eg `user/1` for all queries against Chedburn's user), this module will merge the queries into a
  single `Tornex.Scheduler.ExecutionUnit` representing all of the queries as a single query. The
  `Tornex.Scheduler.ExecutionUnit` will act as a `Tornex.SpecQuery` for the purposes of performing the API
  call with `get/1`, but after the API responds with data, the `Tornex.Scheduler.ExecutionUnit` will split
  the API response for the paths requested by each parent `Tornex.SpecQuery` and respond to the original caller
  of the query.
  """

  defstruct [
    :paths,
    :parameters,
    :key,
    :key_owner,
    :nice,
    :parents
  ]

  @type t :: %__MODULE__{
          paths: [module()],
          parameters: [Tornex.SpecQuery.parameter()],
          key: String.t() | nil,
          key_owner: pos_integer() | nil,
          nice: Tornex.SpecQuery.niceness() | nil,
          parents: [Tornex.SpecQuery.t()]
        }

  @doc """
  Create a new `Tornex.Scheduler.ExecutionUnit`.

  See `Tornex.SpecQuery.new/1` for more information.

  ## Options

    * `:paths` - list of API paths
    * `:parameters` - list of query/path parameters
    * `:key` - API key
    * `:key_owner` - ID of the owner of the API key (default: `0`)
    * `:nice` - Priority of the API call between -20 and 20 (default: `20`)
    * `:parents` - List of parent `Tornex.SpecQuery` (default: `[]`)
  """
  @spec new(opts :: keyword()) :: t()
  def new(opts \\ []) do
    %__MODULE__{
      paths: Keyword.get(opts, :paths, []),
      parameters: Keyword.get(opts, :parameters, []),
      key: Keyword.get(opts, :key, nil),
      key_owner: Keyword.get(opts, :key_owner, nil),
      nice: Keyword.get(opts, :nice, nil),
      parents: Keyword.get(opts, :parents, [])
    }
  end

  @doc """
  Merge a `Tornex.SpecQuery` into a `Tornex.Scheduler.ExecutionUnit`.

  This function will add the paths and parameters of the `Tornex.SpecQuery` into those of
  the `Tornex.Scheduler.ExecutionUnit` such that a portion of the execution unit will represent the 
  parent query. If there is no API key, API key owner, or niceness in the execution unit, those
  of the parent query will be added to the execution unit. If there is already a niceness in the
  execution unit but the parent query has a higher priority niceness, the niceness of the execution
  unit will be replaced with the parent query's niceness.

  **WARNING:** It is assumed that it has already been validated that it is possible to merge the
  `Tornex.SpecQuery` into the `Tornex.Scheduler.ExecutionUnit` in terms of security and how the API functions.
  """
  @spec merge(query :: Tornex.SpecQuery.t(), execution_unit :: t()) :: t()
  def merge(
        %Tornex.SpecQuery{key: query_key, key_owner: query_key_owner, nice: query_nice, origin: origin} = query,
        %__MODULE__{key: key, key_owner: key_owner, nice: nice, parents: eu_parents} = execution_unit
      )
      when not is_nil(origin) and (is_nil(key) or is_nil(key_owner)) do
    # We need to ensure that the key and key owner are initialized. It must be the earliest possible query
    # to be merged as if there are both public and non-public queries to merge into the ExecutionUnit, the 
    # non-public queries are merged first and we need to ensure that the key is that of the query made against 
    # non-public paths.

    execution_unit =
      if is_nil(key) and not is_nil(query_key) do
        %__MODULE__{execution_unit | key: query_key}
      else
        execution_unit
      end

    execution_unit =
      if is_nil(key_owner) and not is_nil(query_key_owner) do
        %__MODULE__{execution_unit | key_owner: query_key_owner}
      else
        execution_unit
      end

    execution_unit =
      if is_nil(nice) and not is_nil(query_nice) do
        %__MODULE__{execution_unit | nice: query_nice}
      else
        execution_unit
      end

    %__MODULE__{} = merged_execution_unit = Tornex.SpecQuery.merge(query, execution_unit)
    %{merged_execution_unit | parents: [query | eu_parents]}
  end

  def merge(%Tornex.SpecQuery{origin: origin} = query, %__MODULE__{parents: eu_parents} = execution_unit)
      when not is_nil(origin) do
    %__MODULE__{} = merged_execution_unit = Tornex.SpecQuery.merge(query, execution_unit)
    %{merged_execution_unit | parents: [query | eu_parents]}
  end

  @doc """
  Convert a `Tornex.Scheduler.ExecutionUnit` to a `Tornex.SpecQuery`.

  When converting the query into an `Tornex.Scheduler.ExecutionUnit`, the API-related data such as the paths and
  API key stored in the struct will be used in the `Tornex.SpecQuery`. This converted `Tornex.SpecQuery` can be
  used as normal.
  """
  @spec to_query(execution_unit :: t()) :: Tornex.SpecQuery.t()
  def to_query(%__MODULE__{} = execution_unit) do
    %Tornex.SpecQuery{
      paths: execution_unit.paths,
      parameters: execution_unit.parameters,
      key: execution_unit.key,
      key_owner: execution_unit.key_owner,
      nice: execution_unit.nice
    }
  end

  @doc """
  Perform an API call against an `Tornex.Scheduler.ExecutionUnit` and forward the API response.

  This function will perform the API call against the paths, parameters, etc. provided by the
  `Tornex.Scheduler.ExecutionUnit` with `Tornex.API.get/1` as normal. However, as there can be multiple
  parents for the `Tornex.Scheduler.ExecutionUnit`, the response needs to be forwarded to all parents.

  To prevent the leakage of potentially sensitive data to other parents and to minimize the size of the
  API responses forwarded, the API response will be split into only the paths requested by the user.
  If the API response is either a Torn error or some intermediate error (such as a CloudFlare error or
  a networking error), the API request may be retried or the error may be forwarded to the parents.
  """
  @spec get(execution_unit :: t()) :: term()
  def get(%__MODULE__{} = execution_unit) do
    execution_unit
    |> to_query()
    |> Tornex.API.get()
    |> reply_fan_out(execution_unit)
  end

  @spec reply_fan_out(response :: map() | list() | Tornex.API.error(), execution_unit :: t()) :: term()
  defp reply_fan_out(response, %__MODULE__{parents: [%Tornex.SpecQuery{} = parent]} = _execution_unit) do
    # If there is only one parent in the ExecutionUnit, it should have already short-circuited when the
    # query was added to the QueryRegistry, but we can still short-circuit it here. Since there's only
    # one parent in the ExecutionUnit, we can just reply to the parent as normal without handling the 
    # response value.

    do_reply(parent, response)
  end

  defp reply_fan_out({:error, _error} = response, %__MODULE__{} = execution_unit) do
    # We do not want to arbitrary retry this in case it's an error such as CF block where retrying it
    # could result in worse "penalties".

    Enum.each(execution_unit.parents, &do_reply(&1, response))
  end

  defp reply_fan_out(%{"error" => %{"code" => 7}} = _response, %__MODULE__{parents: eu_parents} = _execution_unit) do
    # When the error code is 7, we should split up the queries and run them individually as some query
    # had errored with an effectively permission denied error, but not all are guaranteed to do so
    # as some subset of the parent queries could be public queries. To avoid hammering one specific
    # user's API key and to avoid errors of the implementation of Tornex, these queries should be made
    # directly as implemented by the SpecQuery.
    # TODO: Consider doing this for addition error codes such as 16

    Enum.each(eu_parents, fn
      %Tornex.SpecQuery{origin: origin} when is_nil(origin) ->
        # We are unable to respond to queries with no origin, so we can just ignore these queries.
        nil

      %Tornex.SpecQuery{} = query ->
        Tornex.Scheduler.Bucket.make_request(query)

        :ok
    end)
  end

  defp reply_fan_out(%{"error" => %{"code" => error_code}} = response, %__MODULE__{} = execution_unit)
       when is_integer(error_code) do
    # When there is an error whose error code is not handled above, we we should just pass the error onto
    # all of the callers.

    Enum.each(execution_unit.parents, &do_reply(&1, response))
  end

  defp reply_fan_out(response, %__MODULE__{} = execution_unit) when is_map(response) do
    # Since we received a proper API response from the client, we need to split up the API response into
    # the sections required for each client such that the client perceives it to be a normal response.
    Enum.each(execution_unit.parents, &reply_part(&1, response))
  end

  @spec reply_part(query :: Tornex.SpecQuery.t(), response :: map()) :: :ok
  defp reply_part(%Tornex.SpecQuery{paths: paths, origin: origin} = query, response)
       when is_map(response) and not is_nil(origin) do
    # To reply for a specific SpecQuery that is part of an ExecutionUnit, we need to determine which subset
    # of the API response corresponds to the paths requested by the SpecQuery. We do not want to parse the
    # response with Torngen.Client so we must determine if it would be included by the first level string
    # keys from the Torngen.Client repsonse schema modules corresponding to the paths requested.

    path_keys =
      paths
      |> Enum.flat_map(fn path_module when is_atom(path_module) ->
        apply(path_module, :response_modules, [])
      end)
      |> Enum.flat_map(fn response_module_name when is_atom(response_module_name) ->
        response_module = Module.concat(Torngen.Client.Schema, response_module_name)
        apply(response_module, :keys, [])
      end)
      |> Enum.uniq()
      |> Enum.map(&Atom.to_string/1)

    filtered_response_part =
      response
      |> Enum.filter(fn {key, _value} -> Enum.member?(path_keys, key) end)
      |> Map.new()

    do_reply(query, filtered_response_part)
  end

  @spec do_reply(query :: Tornex.SpecQuery.t(), reply_value :: term()) :: :ok | nil
  defp do_reply(%Tornex.SpecQuery{origin: origin} = _query, _reply_value) when is_nil(origin) do
    nil
  end

  defp do_reply(%Tornex.SpecQuery{origin: origin} = _query, reply_value) do
    GenServer.reply(origin, reply_value)
  end
end
