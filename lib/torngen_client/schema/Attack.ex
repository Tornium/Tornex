defmodule Torngen.Client.Schema.Attack do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
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

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:started, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:result, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionAttackResult)
  end

  defp validate_key?(:respect_loss, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:respect_gain, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:modifiers, value) do
    Torngen.Client.Schema.validate?(
      value,
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
    )
  end

  defp validate_key?(:is_stealthed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_ranked_war, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_raid, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_interrupted, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackId)
  end

  defp validate_key?(:finishing_hit_effects, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.AttackingFinishingHitEffects})
  end

  defp validate_key?(:ended, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:defender, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackPlayer)
  end

  defp validate_key?(:code, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackCode)
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:attacker, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
