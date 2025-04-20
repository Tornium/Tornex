defmodule Torngen.Client.Schema.MarketItemMarketResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :itemmarket,
    :_metadata
  ]

  @type t :: %__MODULE__{
          itemmarket: Torngen.Client.Schema.ItemMarket.t(),
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
