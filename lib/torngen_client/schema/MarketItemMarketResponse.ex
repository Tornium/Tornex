defmodule Torngen.Client.Schema.MarketItemMarketResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :itemmarket,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          itemmarket: Torngen.Client.Schema.ItemMarket.t(),
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      itemmarket: Map.get(data, "itemmarket"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
