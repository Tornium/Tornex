defmodule Torngen.Client.Schema.TornFactionHofResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :factionhof,
    :_metadata
  ]

  @type t :: %__MODULE__{
          factionhof: [Torngen.Client.Schema.TornFactionHof.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
