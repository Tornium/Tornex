defmodule Torngen.Client.Schema.FactionRankedWarResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :rankedwars,
    :_metadata
  ]

  @type t :: %__MODULE__{
          rankedwars: [Torngen.Client.Schema.FactionRankedWarDetails.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
