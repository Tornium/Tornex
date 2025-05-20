defmodule Torngen.Client.Schema.ItemMarket do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      listings:
        Map.get(data, "listings")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:one_of,
            [Torngen.Client.Schema.ItemMarketListingStackable, Torngen.Client.Schema.ItemMarketListingNonstackable]}}
        ),
      item: Map.get(data, "item") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketItem)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
