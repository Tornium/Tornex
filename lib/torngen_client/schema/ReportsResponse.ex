defmodule Torngen.Client.Schema.ReportsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:reports, :_metadata]

  defstruct [
    :reports,
    :_metadata
  ]

  @type t :: %__MODULE__{
          reports: [Torngen.Client.Schema.Report.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      reports: data |> Map.get("reports") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.Report}),
      _metadata:
        data |> Map.get("_metadata") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestMetadataWithLinks)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:reports, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.Report})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
