defmodule Torngen.Client.Schema.ItemMarketListingItemBonus do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :title,
    :id,
    :description
  ]

  @type t :: %__MODULE__{
          value: integer(),
          title: String.t(),
          id: integer(),
          description: String.t()
        }
end
