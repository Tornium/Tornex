defmodule Torngen.Client.Schema.UserHofStats do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      working_stats: Map.get(data, "working_stats") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      travel_time: Map.get(data, "travel_time") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      revives: Map.get(data, "revives") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      racing_wins: Map.get(data, "racing_wins") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      racing_skill: Map.get(data, "racing_skill") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      racing_points: Map.get(data, "racing_points") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      offences: Map.get(data, "offences") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      networth: Map.get(data, "networth") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      defends: Map.get(data, "defends") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      busts: Map.get(data, "busts") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      battle_stats:
        Map.get(data, "battle_stats")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.HofValue]}),
      awards: Map.get(data, "awards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      attacks: Map.get(data, "attacks") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
