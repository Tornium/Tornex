defmodule Torngen.Client.Schema.RacerDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      time_ended: Map.get(data, "time_ended"),
      race_time: Map.get(data, "race_time"),
      position: Map.get(data, "position"),
      has_crashed: Map.get(data, "has_crashed"),
      driver_id: Map.get(data, "driver_id"),
      car_item_name: Map.get(data, "car_item_name"),
      car_item_id: Map.get(data, "car_item_id"),
      car_id: Map.get(data, "car_id"),
      car_class: Map.get(data, "car_class"),
      best_lap_time: Map.get(data, "best_lap_time")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
