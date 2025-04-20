defmodule Torngen.Client.Schema.Attack do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :started,
    :result,
    :respect_loss,
    :respect_gain,
    :modifiers,
    :is_stealthed,
    :is_ranked_war,
    :is_raid,
    :is_interrupted,
    :id,
    :finishing_hit_effects,
    :ended,
    :defender,
    :code,
    :chain,
    :attacker
  ]

  @type t :: %__MODULE__{
          started: integer(),
          result: Torngen.Client.Schema.FactionAttackResult.t(),
          respect_loss: integer() | float(),
          respect_gain: integer() | float(),
          modifiers: %{
            :warlord => integer() | float(),
            :war => integer() | float(),
            :retaliation => integer() | float(),
            :overseas => integer() | float(),
            :group => integer() | float(),
            :fair_fight => integer() | float(),
            :chain => integer() | float()
          },
          is_stealthed: boolean(),
          is_ranked_war: boolean(),
          is_raid: boolean(),
          is_interrupted: boolean(),
          id: Torngen.Client.Schema.AttackId.t(),
          finishing_hit_effects: [Torngen.Client.Schema.AttackingFinishingHitEffects.t()],
          ended: integer(),
          defender: Torngen.Client.Schema.AttackPlayer.t(),
          code: Torngen.Client.Schema.AttackCode.t(),
          chain: integer(),
          attacker: nil | Torngen.Client.Schema.AttackPlayer.t()
        }
end
