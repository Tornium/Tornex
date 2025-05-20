defmodule Torngen.Client.Schema.FactionUpgradesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      upgrades: Map.get(data, "upgrades") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionUpgrades),
      state: Map.get(data, "state") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBranchStateEnum)
    }

    # TODO: Handle default values in schema parser and codegen
  end

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
