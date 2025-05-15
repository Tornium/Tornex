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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      top_speed: Map.get(data, "top_speed"),
      tarmac: Map.get(data, "tarmac"),
      safety: Map.get(data, "safety"),
      handling: Map.get(data, "handling"),
      dirt: Map.get(data, "dirt"),
      class: Map.get(data, "class"),
      car_item_name: Map.get(data, "car_item_name"),
      car_item_id: Map.get(data, "car_item_id"),
      braking: Map.get(data, "braking"),
      acceleration: Map.get(data, "acceleration")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
