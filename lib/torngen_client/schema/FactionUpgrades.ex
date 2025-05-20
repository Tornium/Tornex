defmodule Torngen.Client.Schema.FactionUpgrades do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:war, :peace, :core]

  defstruct [
    :war,
    :peace,
    :core
  ]

  @type t :: %__MODULE__{
          war: [Torngen.Client.Schema.FactionBranchDetails.t()],
          peace: [Torngen.Client.Schema.FactionBranchDetails.t()],
          core: %{:upgrades => [Torngen.Client.Schema.FactionUpgradeDetails.t()]}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war: data |> Map.get("war") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionBranchDetails}),
      peace:
        data |> Map.get("peace") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionBranchDetails}),
      core:
        data
        |> Map.get("core")
        |> Torngen.Client.Schema.parse(
          {:object, %{"upgrades" => {:array, Torngen.Client.Schema.FactionUpgradeDetails}}}
        )
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:war, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionBranchDetails})
  end

  defp validate_key?(:peace, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionBranchDetails})
  end

  defp validate_key?(:core, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"upgrades" => {:array, Torngen.Client.Schema.FactionUpgradeDetails}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
