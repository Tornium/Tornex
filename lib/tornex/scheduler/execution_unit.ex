defmodule Tornex.Scheduler.ExecutionUnit do
  @moduledoc """
  An execution unit for the API used by the scheduler to fan out combed queries.
  """

  # TODO: Doducment this module

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

  @spec merge(query :: Tornex.SpecQuery.t(), execution_unit :: t()) :: t()
  def merge(
        %Tornex.SpecQuery{key: query_key, key_owner: query_key_owner, nice: query_nice} = query,
        %__MODULE__{key: key, key_owner: key_owner, nice: nice, parents: eu_parents} = execution_unit
      )
      when is_nil(key) or is_nil(key_owner) do
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

    merged_execution_unit = Tornex.SpecQuery.merge(query, execution_unit)
    %__MODULE__{merged_execution_unit | parents: [query | eu_parents]}
  end

  def merge(%Tornex.SpecQuery{} = query, %__MODULE__{parents: eu_parents} = execution_unit) do
    merged_execution_unit = Tornex.SpecQuery.merge(query, execution_unit)
    %__MODULE__{merged_execution_unit | parents: [query | eu_parents]}
  end

  @doc """
  Convert an `ExecutionUnit` to a `SpecQuery`.
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

  # TODO: Determine response type
  @spec get(execution_unit :: t()) :: term()
  def get(%__MODULE__{} = execution_unit) do
    execution_unit
    |> to_query()
    |> Tornex.API.get()
    |> reply_fan_out(execution_unit)
  end

  # TODO: Determine response type
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
    end)
  end

  defp reply_fan_out(%{"error" => %{"code" => error_code}} = response, %__MODULE__{} = execution_unit)
       when is_integer(error_code) do
    # When there is an error whose error code is not handled above, we we should just pass the error onto
    # all of the callers.

    Enum.each(execution_unit.parents, &do_reply(&1, response))
  end

  defp reply_fan_out(response, %__MODULE__{} = _execution_unit) when is_map(response) do
    # Since we received a proper API response from the client, we need to split up the API response into
    # the sections required for each client such that the client perceives it to be a normal response.
    # TODO: We need to split up the response into the sections necessary for each caller
  end

  @spec do_reply(query :: Tornex.SpecQuery.t(), reply_value :: term()) :: term()
  defp do_reply(%Tornex.SpecQuery{origin: origin} = _query, _reply_value) when is_nil(origin) do
    nil
  end

  defp do_reply(%Tornex.SpecQuery{origin: origin} = _query, reply_value) do
    GenServer.reply(origin, reply_value)
  end
end
