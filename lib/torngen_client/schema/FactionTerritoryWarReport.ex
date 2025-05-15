defmodule Torngen.Client.Schema.FactionTerritoryWarReport do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :territory,
    :started_at,
    :result,
    :id,
    :factions,
    :ended_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          winner: Torngen.Client.Schema.FactionId.t(),
          territory: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          started_at: integer(),
          result: String.t(),
          id: Torngen.Client.Schema.TerritoryWarId.t(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarReportFaction.t()],
          ended_at: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner: Map.get(data, "winner"),
      territory: Map.get(data, "territory"),
      started_at: Map.get(data, "started_at"),
      result: Map.get(data, "result"),
      id: Map.get(data, "id"),
      factions: Map.get(data, "factions"),
      ended_at: Map.get(data, "ended_at")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
