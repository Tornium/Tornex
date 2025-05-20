defmodule Torngen.Client.Schema.UserPersonalStatsHistoric do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:personalstats]

  defstruct [
    :personalstats
  ]

  @type t :: %__MODULE__{
          personalstats: [Torngen.Client.Schema.PersonalStatsHistoricStat.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      personalstats:
        Map.get(data, "personalstats")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.PersonalStatsHistoricStat})
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

  defp validate_key?(:personalstats, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.PersonalStatsHistoricStat})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
