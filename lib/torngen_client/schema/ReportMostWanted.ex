defmodule Torngen.Client.Schema.ReportMostWanted do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:top, :notable]

  defstruct [
    :top,
    :notable
  ]

  @type t :: %__MODULE__{
          top: [Torngen.Client.Schema.ReportWarrantDetails.t()],
          notable: [Torngen.Client.Schema.ReportWarrantDetails.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      top: data |> Map.get("top") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ReportWarrantDetails}),
      notable:
        data |> Map.get("notable") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ReportWarrantDetails})
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

  defp validate_key?(:top, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ReportWarrantDetails})
  end

  defp validate_key?(:notable, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ReportWarrantDetails})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
