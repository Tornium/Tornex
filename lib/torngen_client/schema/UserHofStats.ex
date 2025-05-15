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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      working_stats: Map.get(data, "working_stats"),
      travel_time: Map.get(data, "travel_time"),
      revives: Map.get(data, "revives"),
      rank: Map.get(data, "rank"),
      racing_wins: Map.get(data, "racing_wins"),
      racing_skill: Map.get(data, "racing_skill"),
      racing_points: Map.get(data, "racing_points"),
      offences: Map.get(data, "offences"),
      networth: Map.get(data, "networth"),
      level: Map.get(data, "level"),
      defends: Map.get(data, "defends"),
      busts: Map.get(data, "busts"),
      battle_stats: Map.get(data, "battle_stats"),
      awards: Map.get(data, "awards"),
      attacks: Map.get(data, "attacks")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
