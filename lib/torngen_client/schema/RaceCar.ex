defmodule Torngen.Client.Schema.RaceCar do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

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
end
