defmodule Torngen.Client.Schema.FactionNewsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :news,
    :_metadata
  ]

  @type t :: %__MODULE__{
          news: [Torngen.Client.Schema.FactionNews.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
