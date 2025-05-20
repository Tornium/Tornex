defmodule Torngen.Client.Schema.FactionWars do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territory, :ranked, :raids]

  defstruct [
    :territory,
    :ranked,
    :raids
  ]

  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.FactionTerritoryWar.t()],
          ranked: nil | Torngen.Client.Schema.FactionRankedWar.t(),
          raids: [Torngen.Client.Schema.FactionRaidWar.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory:
        Map.get(data, "territory") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWar}),
      ranked:
        Map.get(data, "ranked")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionRankedWar]}),
      raids: Map.get(data, "raids") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRaidWar})
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:territory, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.FactionTerritoryWar})
  end

  defp validate_key(:ranked, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionRankedWar]})
  end

  defp validate_key(:raids, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.FactionRaidWar})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
