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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          value: integer(),
          title: String.t(),
          id: integer(),
          description: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value"),
      title: Map.get(data, "title"),
      id: Map.get(data, "id"),
      description: Map.get(data, "description")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
