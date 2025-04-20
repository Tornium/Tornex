defmodule Torngen.Client.Schema.TornHof do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :username,
    :signed_up,
    :rank_number,
    :rank_name,
    :rank,
    :position,
    :level,
    :last_action,
    :id,
    :faction_id,
    :age_in_days
  ]

  @type t :: %__MODULE__{
          value: term(),
          username: String.t(),
          signed_up: integer(),
          rank_number: integer(),
          rank_name: String.t(),
          rank: String.t(),
          position: integer(),
          level: integer(),
          last_action: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: Torngen.Client.Schema.FactionId.t(),
          age_in_days: integer()
        }
end
