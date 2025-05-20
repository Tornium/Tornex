defmodule Torngen.Client.Schema.UserHofStats do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      working_stats: data |> Map.get("working_stats") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      travel_time: data |> Map.get("travel_time") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      revives: data |> Map.get("revives") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      rank: data |> Map.get("rank") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      racing_wins: data |> Map.get("racing_wins") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      racing_skill: data |> Map.get("racing_skill") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      racing_points: data |> Map.get("racing_points") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      offences: data |> Map.get("offences") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      networth: data |> Map.get("networth") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      defends: data |> Map.get("defends") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      busts: data |> Map.get("busts") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      battle_stats:
        data
        |> Map.get("battle_stats")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.HofValue]}),
      awards: data |> Map.get("awards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      attacks: data |> Map.get("attacks") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:working_stats, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:travel_time, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:revives, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:rank, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:racing_wins, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:racing_skill, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:racing_points, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:offences, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:networth, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:defends, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:busts, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:battle_stats, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.HofValue]})
  end

  defp validate_key?(:awards, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:attacks, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
