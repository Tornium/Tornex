defmodule Torngen.Client.Schema.FactionRaidWarParticipant do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :name,
    :is_aggressor,
    :id,
    :chain
  ]

  @type t :: %__MODULE__{
          score: integer(),
          name: String.t(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }
end
