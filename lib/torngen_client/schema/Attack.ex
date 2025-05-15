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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      started: Map.get(data, "started"),
      result: Map.get(data, "result"),
      respect_loss: Map.get(data, "respect_loss"),
      respect_gain: Map.get(data, "respect_gain"),
      modifiers: Map.get(data, "modifiers"),
      is_stealthed: Map.get(data, "is_stealthed"),
      is_ranked_war: Map.get(data, "is_ranked_war"),
      is_raid: Map.get(data, "is_raid"),
      is_interrupted: Map.get(data, "is_interrupted"),
      id: Map.get(data, "id"),
      finishing_hit_effects: Map.get(data, "finishing_hit_effects"),
      ended: Map.get(data, "ended"),
      defender: Map.get(data, "defender"),
      code: Map.get(data, "code"),
      chain: Map.get(data, "chain"),
      attacker: Map.get(data, "attacker")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
