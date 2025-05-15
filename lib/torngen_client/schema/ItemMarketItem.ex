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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          type: String.t(),
          name: String.t(),
          id: Torngen.Client.Schema.ItemId.t(),
          average_price: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      average_price: Map.get(data, "average_price")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
