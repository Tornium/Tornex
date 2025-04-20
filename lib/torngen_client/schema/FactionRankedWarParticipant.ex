defmodule Torngen.Client.Schema.FactionRankedWarParticipant do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :name,
    :id,
    :chain
  ]

  @type t :: %__MODULE__{
          score: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }
end
