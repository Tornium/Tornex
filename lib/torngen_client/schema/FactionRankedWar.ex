defmodule Torngen.Client.Schema.FactionRankedWar do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :war_id,
    :target,
    :start,
    :factions,
    :end
  ]

  @type t :: %__MODULE__{
          winner: nil | integer(),
          war_id: integer(),
          target: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionRankedWarParticipant.t()],
          end: nil | integer()
        }
end
