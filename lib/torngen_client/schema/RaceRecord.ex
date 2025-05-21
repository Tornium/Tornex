defmodule Torngen.Client.Schema.RaceRecord do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:lap_time, :driver_name, :driver_id, :car_item_name, :car_item_id]

  defstruct [
    :lap_time,
    :driver_name,
    :driver_id,
    :car_item_name,
    :car_item_id
  ]

  @type t :: %__MODULE__{
          lap_time: integer() | float(),
          driver_name: String.t(),
          driver_id: Torngen.Client.Schema.UserId.t(),
          car_item_name: String.t(),
          car_item_id: Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      lap_time: data |> Map.get("lap_time") |> Torngen.Client.Schema.parse({:static, :number}),
      driver_name: data |> Map.get("driver_name") |> Torngen.Client.Schema.parse({:static, :string}),
      driver_id: data |> Map.get("driver_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      car_item_name: data |> Map.get("car_item_name") |> Torngen.Client.Schema.parse({:static, :string}),
      car_item_id: data |> Map.get("car_item_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:lap_time, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:driver_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:driver_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:car_item_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:car_item_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
