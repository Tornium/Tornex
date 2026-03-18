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
      ) when is_nil(key) or is_nil(key_owner) do
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
end
