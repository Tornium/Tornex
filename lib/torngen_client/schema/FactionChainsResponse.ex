defmodule Torngen.Client.Schema.FactionChainsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :chains,
    :_metadata
  ]

  @type t :: %__MODULE__{
          chains: [Torngen.Client.Schema.FactionChain.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
