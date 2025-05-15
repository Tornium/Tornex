defmodule Torngen.Client.Schema.TornItem do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :type,
    :sub_type,
    :requirement,
    :name,
    :is_tradable,
    :is_masked,
    :is_found_in_city,
    :image,
    :id,
    :effect,
    :details,
    :description,
    :circulation
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          value: %{
            :vendor => nil | %{:name => String.t(), :country => String.t()},
            :sell_price => nil | integer(),
            :market_price => integer(),
            :buy_price => nil | integer()
          },
          type: Torngen.Client.Schema.TornItemTypeEnum.t(),
          sub_type: nil | Torngen.Client.Schema.TornItemWeaponTypeEnum.t(),
          requirement: nil | String.t(),
          name: String.t(),
          is_tradable: boolean(),
          is_masked: boolean(),
          is_found_in_city: boolean(),
          image: String.t(),
          id: Torngen.Client.Schema.ItemId.t(),
          effect: nil | String.t(),
          details:
            nil | Torngen.Client.Schema.TornItemArmorDetails.t() | Torngen.Client.Schema.TornItemWeaponDetails.t(),
          description: String.t(),
          circulation: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value"),
      type: Map.get(data, "type"),
      sub_type: Map.get(data, "sub_type"),
      requirement: Map.get(data, "requirement"),
      name: Map.get(data, "name"),
      is_tradable: Map.get(data, "is_tradable"),
      is_masked: Map.get(data, "is_masked"),
      is_found_in_city: Map.get(data, "is_found_in_city"),
      image: Map.get(data, "image"),
      id: Map.get(data, "id"),
      effect: Map.get(data, "effect"),
      details: Map.get(data, "details"),
      description: Map.get(data, "description"),
      circulation: Map.get(data, "circulation")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
