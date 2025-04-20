defmodule Torngen.Client.Schema.FactionAttacksResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacks,
    :_metadata
  ]

  @type t :: %__MODULE__{
          attacks: [Torngen.Client.Schema.Attack.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
