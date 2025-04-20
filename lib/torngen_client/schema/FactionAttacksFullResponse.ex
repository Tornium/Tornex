defmodule Torngen.Client.Schema.FactionAttacksFullResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacks,
    :_metadata
  ]

  @type t :: %__MODULE__{
          attacks: [Torngen.Client.Schema.AttackSimplified.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
