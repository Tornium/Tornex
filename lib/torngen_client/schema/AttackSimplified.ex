defmodule Torngen.Client.Schema.AttackSimplified do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :started,
    :result,
    :respect_loss,
    :respect_gain,
    :id,
    :ended,
    :defender,
    :code,
    :attacker
  ]

  @type t :: %__MODULE__{
          started: integer(),
          result: Torngen.Client.Schema.FactionAttackResult.t(),
          respect_loss: integer() | float(),
          respect_gain: integer() | float(),
          id: Torngen.Client.Schema.AttackId.t(),
          ended: integer(),
          defender: Torngen.Client.Schema.AttackPlayerSimplified.t(),
          code: Torngen.Client.Schema.AttackCode.t(),
          attacker: nil | Torngen.Client.Schema.AttackPlayerSimplified.t()
        }
end
