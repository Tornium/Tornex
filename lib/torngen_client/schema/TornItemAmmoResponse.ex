defmodule Torngen.Client.Schema.TornItemAmmoResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:itemammo]

  defstruct [
    :itemammo
  ]

  @type t :: %__MODULE__{
          itemammo: [Torngen.Client.Schema.TornItemAmmo.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      itemammo: data |> Map.get("itemammo") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemAmmo})
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

  defp validate_key?(:itemammo, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornItemAmmo})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
