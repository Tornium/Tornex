defmodule Torngen.Client.Schema.FactionTerritoryWar do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :war_id,
    :territory,
    :target,
    :start,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          war_id: integer(),
          territory: String.t(),
          target: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarParticipant.t()],
          end: nil | integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner: Map.get(data, "winner"),
      war_id: Map.get(data, "war_id"),
      territory: Map.get(data, "territory"),
      target: Map.get(data, "target"),
      start: Map.get(data, "start"),
      factions: Map.get(data, "factions"),
      end: Map.get(data, "end")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
