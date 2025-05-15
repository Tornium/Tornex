defmodule Torngen.Client.Schema.ItemMarket do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :listings,
    :item
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          listings: [
            Torngen.Client.Schema.ItemMarketListingStackable.t()
            | Torngen.Client.Schema.ItemMarketListingNonstackable.t()
          ],
          item: Torngen.Client.Schema.ItemMarketItem.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      listings: Map.get(data, "listings"),
      item: Map.get(data, "item")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
