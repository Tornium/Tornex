defmodule Torngen.Client.Schema.RaceCar do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:top_speed, :tarmac, :safety, :handling, :dirt, :class, :car_item_name, :car_item_id, :braking, :acceleration]

  defstruct [
    :top_speed,
    :tarmac,
    :safety,
    :handling,
    :dirt,
    :class,
    :car_item_name,
    :car_item_id,
    :braking,
    :acceleration
  ]

  @type t :: %__MODULE__{
          top_speed: integer(),
          tarmac: integer(),
          safety: integer(),
          handling: integer(),
          dirt: integer(),
          class: Torngen.Client.Schema.RaceClassEnum.t(),
          car_item_name: String.t(),
          car_item_id: Torngen.Client.Schema.ItemId.t(),
          braking: integer(),
          acceleration: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      top_speed: Map.get(data, "top_speed") |> Torngen.Client.Schema.parse({:static, :integer}),
      tarmac: Map.get(data, "tarmac") |> Torngen.Client.Schema.parse({:static, :integer}),
      safety: Map.get(data, "safety") |> Torngen.Client.Schema.parse({:static, :integer}),
      handling: Map.get(data, "handling") |> Torngen.Client.Schema.parse({:static, :integer}),
      dirt: Map.get(data, "dirt") |> Torngen.Client.Schema.parse({:static, :integer}),
      class: Map.get(data, "class") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceClassEnum),
      car_item_name: Map.get(data, "car_item_name") |> Torngen.Client.Schema.parse({:static, :string}),
      car_item_id: Map.get(data, "car_item_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId),
      braking: Map.get(data, "braking") |> Torngen.Client.Schema.parse({:static, :integer}),
      acceleration: Map.get(data, "acceleration") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:top_speed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:tarmac, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:safety, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:handling, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:dirt, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:class, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceClassEnum)
  end

  defp validate_key?(:car_item_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:car_item_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemId)
  end

  defp validate_key?(:braking, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:acceleration, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
