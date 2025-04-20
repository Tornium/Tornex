defmodule Torngen.Client.Schema.RevivesFullResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :revives,
    :_metadata
  ]

  @type t :: %__MODULE__{
          revives: [Torngen.Client.Schema.ReviveSimplified.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
