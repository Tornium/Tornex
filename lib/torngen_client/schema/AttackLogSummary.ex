defmodule Torngen.Client.Schema.AttackLogSummary do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :misses,
    :id,
    :hits,
    :damage
  ]

  @type t :: %__MODULE__{
          name: nil | String.t(),
          misses: integer(),
          id: nil | Torngen.Client.Schema.UserId.t(),
          hits: integer(),
          damage: integer()
        }
end
