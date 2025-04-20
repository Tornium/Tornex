defmodule Torngen.Client.Schema.RaceRecord do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

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
end
