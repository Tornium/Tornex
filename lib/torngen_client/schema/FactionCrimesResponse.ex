defmodule Torngen.Client.Schema.FactionCrimesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crimes,
    :_metadata
  ]

  @type t :: %__MODULE__{
          crimes: [Torngen.Client.Schema.FactionCrime.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
