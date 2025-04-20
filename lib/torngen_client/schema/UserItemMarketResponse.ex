defmodule Torngen.Client.Schema.UserItemMarketResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :itemmarket,
    :_metadata
  ]

  @type t :: %__MODULE__{
          itemmarket: [Torngen.Client.Schema.UserItemMarketListing.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
