defmodule Torngen.Client.Schema.RacingRacesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :races,
    :_metadata
  ]

  @type t :: %__MODULE__{
          races: [Torngen.Client.Schema.Race.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
