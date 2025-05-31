defmodule Torngen.Client.Schema.FactionUpgradesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:upgrades, :state]

  defstruct [
    :upgrades,
    :state
  ]

  @type t :: %__MODULE__{
          upgrades: Torngen.Client.Schema.FactionUpgrades.t(),
          state: Torngen.Client.Schema.FactionBranchStateEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      upgrades: data |> Map.get("upgrades") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionUpgrades),
      state: data |> Map.get("state") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBranchStateEnum)
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

  defp validate_key?(:upgrades, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionUpgrades)
  end

  defp validate_key?(:state, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionBranchStateEnum)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
