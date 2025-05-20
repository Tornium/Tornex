defmodule Torngen.Client.Schema.UserItemMarketListing do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :price,
    :item,
    :is_anonymous,
    :id,
    :average_price,
    :available,
    :amount
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          price: integer(),
          item: Torngen.Client.Schema.UserItemMarkeListingItemDetails.t(),
          is_anonymous: boolean(),
          id: integer(),
          average_price: integer(),
          available: integer(),
          amount: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: Map.get(data, "price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item: Map.get(data, "item") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserItemMarkeListingItemDetails),
      is_anonymous: Map.get(data, "is_anonymous") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer}),
      average_price: Map.get(data, "average_price") |> Torngen.Client.Schema.parse({:static, :integer}),
      available: Map.get(data, "available") |> Torngen.Client.Schema.parse({:static, :integer}),
      amount: Map.get(data, "amount") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
