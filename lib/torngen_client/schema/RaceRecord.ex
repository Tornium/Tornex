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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          lap_time: integer() | float(),
          driver_name: String.t(),
          driver_id: Torngen.Client.Schema.UserId.t(),
          car_item_name: String.t(),
          car_item_id: Torngen.Client.Schema.ItemId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      lap_time: Map.get(data, "lap_time"),
      driver_name: Map.get(data, "driver_name"),
      driver_id: Map.get(data, "driver_id"),
      car_item_name: Map.get(data, "car_item_name"),
      car_item_id: Map.get(data, "car_item_id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
