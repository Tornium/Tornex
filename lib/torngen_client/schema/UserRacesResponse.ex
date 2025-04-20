defmodule Torngen.Client.Schema.UserRacesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :races,
    :_metadata
  ]

  @type t :: %__MODULE__{
          races: [Torngen.Client.Schema.RacingRaceDetailsResponse.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
