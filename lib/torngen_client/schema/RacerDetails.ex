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
end
