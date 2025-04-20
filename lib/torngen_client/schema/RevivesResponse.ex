defmodule Torngen.Client.Schema.RevivesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :revives,
    :_metadata
  ]

  @type t :: %__MODULE__{
          revives: [Torngen.Client.Schema.Revive.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
