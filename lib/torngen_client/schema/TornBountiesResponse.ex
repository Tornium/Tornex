defmodule Torngen.Client.Schema.TornBountiesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :bounties,
    :_metadata
  ]

  @type t :: %__MODULE__{
          bounties: [Torngen.Client.Schema.Bounty.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
