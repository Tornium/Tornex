defmodule Torngen.Client.Schema.RaceTrack do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :title,
    :id,
    :description
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          id: Torngen.Client.Schema.RaceTrackId.t(),
          description: String.t()
        }
end
