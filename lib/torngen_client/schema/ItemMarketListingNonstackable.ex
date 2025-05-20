defmodule Torngen.Client.Schema.ItemMarketListingNonstackable do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :price,
    :item_details,
    :amount
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          price: integer(),
          item_details: Torngen.Client.Schema.ItemMarketListingItemDetails.t(),
          amount: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: Map.get(data, "price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item_details:
        Map.get(data, "item_details") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketListingItemDetails),
      amount: Map.get(data, "amount") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
