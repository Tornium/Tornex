defmodule Torngen.Client.Schema.RaceRecord do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      lap_time: Map.get(data, "lap_time") |> Torngen.Client.Schema.parse({:static, :number}),
      driver_name: Map.get(data, "driver_name") |> Torngen.Client.Schema.parse({:static, :string}),
      driver_id: Map.get(data, "driver_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      car_item_name: Map.get(data, "car_item_name") |> Torngen.Client.Schema.parse({:static, :string}),
      car_item_id: Map.get(data, "car_item_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
