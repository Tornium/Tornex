defmodule Torngen.Client.Schema.ReportHistory do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:factions, :companies]

  defstruct [
    :factions,
    :companies
  ]

  @type t :: %__MODULE__{
          factions: [Torngen.Client.Schema.ReportHistoryFaction.t()],
          companies: [Torngen.Client.Schema.ReportHistoryCompany.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      factions:
        data |> Map.get("factions") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ReportHistoryFaction}),
      companies:
        data
        |> Map.get("companies")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ReportHistoryCompany})
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

  defp validate_key?(:factions, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ReportHistoryFaction})
  end

  defp validate_key?(:companies, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ReportHistoryCompany})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
