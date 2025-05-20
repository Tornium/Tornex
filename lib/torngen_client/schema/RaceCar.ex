defmodule Torngen.Client.Schema.RaceCar do
  @moduledoc """
  [SHORT DESCRIPTION]
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
end
