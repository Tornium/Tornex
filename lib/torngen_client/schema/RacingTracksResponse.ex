defmodule Torngen.Client.Schema.RacingTracksResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :tracks
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          tracks: [Torngen.Client.Schema.RaceTrack.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tracks: Map.get(data, "tracks") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceTrack})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
