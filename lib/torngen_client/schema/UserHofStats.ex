defmodule Torngen.Client.Schema.UserHofStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :working_stats,
    :travel_time,
    :revives,
    :rank,
    :racing_wins,
    :racing_skill,
    :racing_points,
    :offences,
    :networth,
    :level,
    :defends,
    :busts,
    :battle_stats,
    :awards,
    :attacks
  ]

  @type t :: %__MODULE__{
          working_stats: Torngen.Client.Schema.HofValue.t(),
          travel_time: Torngen.Client.Schema.HofValue.t(),
          revives: Torngen.Client.Schema.HofValue.t(),
          rank: Torngen.Client.Schema.HofValue.t(),
          racing_wins: Torngen.Client.Schema.HofValue.t(),
          racing_skill: Torngen.Client.Schema.HofValue.t(),
          racing_points: Torngen.Client.Schema.HofValue.t(),
          offences: Torngen.Client.Schema.HofValue.t(),
          networth: Torngen.Client.Schema.HofValue.t(),
          level: Torngen.Client.Schema.HofValue.t(),
          defends: Torngen.Client.Schema.HofValue.t(),
          busts: Torngen.Client.Schema.HofValue.t(),
          battle_stats: nil | Torngen.Client.Schema.HofValue.t(),
          awards: Torngen.Client.Schema.HofValue.t(),
          attacks: Torngen.Client.Schema.HofValue.t()
        }
end
