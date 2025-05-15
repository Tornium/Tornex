defmodule Torngen.Client.Schema.ItemMarketListingStackable do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :price,
    :amount
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          price: integer(),
          amount: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: Map.get(data, "price"),
      amount: Map.get(data, "amount")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
