defmodule Torngen.Client.Schema.FactionChainReport do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: [:"non-attackers"]

  @behaviour Torngen.Client.Schema

  @keys [:start, :non_attackers, :"non-attackers", :id, :faction_id, :end, :details, :bonuses, :attackers]

  defstruct [
    :start,
    :non_attackers,
    :"non-attackers",
    :id,
    :faction_id,
    :end,
    :details,
    :bonuses,
    :attackers
  ]

  @type t :: %__MODULE__{
          start: integer(),
          non_attackers: [Torngen.Client.Schema.UserId.t()],
          "non-attackers": [Torngen.Client.Schema.UserId.t()],
          id: Torngen.Client.Schema.ChainId.t(),
          faction_id: Torngen.Client.Schema.FactionId.t(),
          end: integer(),
          details: Torngen.Client.Schema.FactionChainReportDetails.t(),
          bonuses: [Torngen.Client.Schema.FactionChainReportBonus.t()],
          attackers: [Torngen.Client.Schema.FactionChainReportAttacker.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      non_attackers:
        data |> Map.get("non_attackers") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserId}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ChainId),
      faction_id: data |> Map.get("faction_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :integer}),
      details:
        data |> Map.get("details") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReportDetails),
      bonuses:
        data
        |> Map.get("bonuses")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionChainReportBonus}),
      attackers:
        data
        |> Map.get("attackers")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionChainReportAttacker})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:non_attackers, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:"non-attackers", value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ChainId)
  end

  defp validate_key?(:faction_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:details, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionChainReportDetails)
  end

  defp validate_key?(:bonuses, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionChainReportBonus})
  end

  defp validate_key?(:attackers, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionChainReportAttacker})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
