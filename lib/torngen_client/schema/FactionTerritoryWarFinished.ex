defmodule Torngen.Client.Schema.FactionTerritoryWarFinished do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territory,
    :target,
    :start,
    :result,
    :id,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territory: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          target: integer(),
          start: integer(),
          result: Torngen.Client.Schema.FactionTerritoryWarResultEnum.t(),
          id: Torngen.Client.Schema.TerritoryWarId.t(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarFinishedFaction.t()],
          end: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory: Map.get(data, "territory"),
      target: Map.get(data, "target"),
      start: Map.get(data, "start"),
      result: Map.get(data, "result"),
      id: Map.get(data, "id"),
      factions: Map.get(data, "factions"),
      end: Map.get(data, "end")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
