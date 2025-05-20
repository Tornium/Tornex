defmodule Torngen.Client.Schema.RacingCarUpgradesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:carupgrades]

  defstruct [
    :carupgrades
  ]

  @type t :: %__MODULE__{
          carupgrades: [Torngen.Client.Schema.RaceCarUpgrade.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      carupgrades:
        Map.get(data, "carupgrades") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceCarUpgrade})
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

  defp validate_key?(:carupgrades, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.RaceCarUpgrade})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
