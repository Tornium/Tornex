defmodule Torngen.Client.Schema.ItemMarketListingItemStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :quality,
    :damage,
    :armor,
    :accuracy
  ]

  @type t :: %__MODULE__{
          quality: integer() | float(),
          damage: nil | integer() | float(),
          armor: nil | integer() | float(),
          accuracy: nil | integer() | float()
        }
end
