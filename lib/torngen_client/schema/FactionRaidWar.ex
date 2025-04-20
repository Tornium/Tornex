defmodule Torngen.Client.Schema.FactionRaidWar do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war_id,
    :start,
    :factions,
    :end
  ]

  @type t :: %__MODULE__{
          war_id: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionRaidWarParticipant.t()],
          end: nil | integer()
        }
end
