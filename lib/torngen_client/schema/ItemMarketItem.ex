defmodule Torngen.Client.Schema.ItemMarketItem do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :type,
    :name,
    :id,
    :average_price
  ]

  @type t :: %__MODULE__{
          type: String.t(),
          name: String.t(),
          id: Torngen.Client.Schema.ItemId.t(),
          average_price: integer()
        }
end
