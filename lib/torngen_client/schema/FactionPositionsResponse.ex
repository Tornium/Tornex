defmodule Torngen.Client.Schema.FactionPositionsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:positions]

  defstruct [
    :positions
  ]

  @type t :: %__MODULE__{
          positions: [Torngen.Client.Schema.FactionPosition.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      positions:
        data |> Map.get("positions") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionPosition})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:positions, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionPosition})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
