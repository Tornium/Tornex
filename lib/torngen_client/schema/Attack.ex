defmodule Torngen.Client.Schema.Attack do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      started: Map.get(data, "started") |> Torngen.Client.Schema.parse({:static, :integer}),
      result: Map.get(data, "result") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionAttackResult),
      respect_loss: Map.get(data, "respect_loss") |> Torngen.Client.Schema.parse({:static, :number}),
      respect_gain: Map.get(data, "respect_gain") |> Torngen.Client.Schema.parse({:static, :number}),
      modifiers:
        Map.get(data, "modifiers")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "chain" => {:static, :number},
             "fair_fight" => {:static, :number},
             "group" => {:static, :number},
             "overseas" => {:static, :number},
             "retaliation" => {:static, :number},
             "war" => {:static, :number},
             "warlord" => {:static, :number}
           }}
        ),
      is_stealthed: Map.get(data, "is_stealthed") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_ranked_war: Map.get(data, "is_ranked_war") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_raid: Map.get(data, "is_raid") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_interrupted: Map.get(data, "is_interrupted") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackId),
      finishing_hit_effects:
        Map.get(data, "finishing_hit_effects")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.AttackingFinishingHitEffects}),
      ended: Map.get(data, "ended") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender: Map.get(data, "defender") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackPlayer),
      code: Map.get(data, "code") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackCode),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse({:static, :integer}),
      attacker:
        Map.get(data, "attacker")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayer]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
