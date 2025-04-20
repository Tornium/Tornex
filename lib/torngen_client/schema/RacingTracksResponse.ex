defmodule Torngen.Client.Schema.RacingTracksResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :tracks
  ]

  @type t :: %__MODULE__{
          tracks: [Torngen.Client.Schema.RaceTrack.t()]
        }
end
