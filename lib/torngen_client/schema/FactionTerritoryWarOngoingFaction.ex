defmodule Torngen.Client.Schema.FactionTerritoryWarOngoingFaction do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :playerIds,
    :name,
    :is_aggressor,
    :id,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          score: integer(),
          playerIds: [Torngen.Client.Schema.UserId.t()],
          name: String.t(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: Map.get(data, "score"),
      playerIds: Map.get(data, "playerIds"),
      name: Map.get(data, "name"),
      is_aggressor: Map.get(data, "is_aggressor"),
      id: Map.get(data, "id"),
      chain: Map.get(data, "chain")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
