defmodule Torngen.Client.Schema.FactionCrimeUser do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :progress,
    :outcome,
    :joined_at,
    :id
  ]

  @type t :: %__MODULE__{
          progress: integer() | float(),
          outcome: nil | Torngen.Client.Schema.FactionCrimeUserOutcome.t(),
          joined_at: integer(),
          id: Torngen.Client.Schema.UserId.t()
        }
end
