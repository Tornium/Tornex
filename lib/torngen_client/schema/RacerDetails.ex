defmodule Torngen.Client.Schema.RacerDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :time_ended,
    :race_time,
    :position,
    :has_crashed,
    :driver_id,
    :car_item_name,
    :car_item_id,
    :car_id,
    :car_class,
    :best_lap_time
  ]

  defstruct [
    :time_ended,
    :race_time,
    :position,
    :has_crashed,
    :driver_id,
    :car_item_name,
    :car_item_id,
    :car_id,
    :car_class,
    :best_lap_time
  ]

  @type t :: %__MODULE__{
          time_ended: nil | integer(),
          race_time: nil | integer() | float(),
          position: nil | integer(),
          has_crashed: nil | boolean(),
          driver_id: Torngen.Client.Schema.UserId.t(),
          car_item_name: String.t(),
          car_item_id: Torngen.Client.Schema.ItemId.t(),
          car_id: Torngen.Client.Schema.RaceCarId.t(),
          car_class: Torngen.Client.Schema.RaceClassEnum.t(),
          best_lap_time: nil | integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      time_ended:
        Map.get(data, "time_ended") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      race_time: Map.get(data, "race_time") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]}),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      has_crashed:
        Map.get(data, "has_crashed") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :boolean]}),
      driver_id: Map.get(data, "driver_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      car_item_name: Map.get(data, "car_item_name") |> Torngen.Client.Schema.parse({:static, :string}),
      car_item_id: Map.get(data, "car_item_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId),
      car_id: Map.get(data, "car_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceCarId),
      car_class: Map.get(data, "car_class") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceClassEnum),
      best_lap_time:
        Map.get(data, "best_lap_time") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]})
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

  defp validate_key(:time_ended, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key(:race_time, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :number]})
  end

  defp validate_key(:position, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key(:has_crashed, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :boolean]})
  end

  defp validate_key(:driver_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:car_item_name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:car_item_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ItemId)
  end

  defp validate_key(:car_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.RaceCarId)
  end

  defp validate_key(:car_class, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.RaceClassEnum)
  end

  defp validate_key(:best_lap_time, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :number]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
