defmodule Torngen.Client.Schema.TornHofResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hof,
    :_metadata
  ]

  @type t :: %__MODULE__{
          hof: [Torngen.Client.Schema.TornHof.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
