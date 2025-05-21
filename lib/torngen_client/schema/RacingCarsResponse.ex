defmodule Torngen.Client.Schema.RacingCarsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:cars]

  defstruct [
    :cars
  ]

  @type t :: %__MODULE__{
          cars: [Torngen.Client.Schema.RaceCar.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      cars: data |> Map.get("cars") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceCar})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:cars, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.RaceCar})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
