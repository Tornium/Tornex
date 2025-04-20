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

  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          war_id: integer(),
          territory: String.t(),
          target: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarParticipant.t()],
          end: nil | integer()
        }
end
