defmodule Torngen.Client.Schema.ItemMarketListingStackable do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :price,
    :amount
  ]

  @type t :: %__MODULE__{
          price: integer(),
          amount: integer()
        }
end
