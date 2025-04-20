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
end
