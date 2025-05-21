defmodule Torngen.Client.Schema.UserCrime do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uniques, :skill, :rewards, :progression_bonus, :nerve_spent, :miscellaneous, :attempts]

  defstruct [
    :uniques,
    :skill,
    :rewards,
    :progression_bonus,
    :nerve_spent,
    :miscellaneous,
    :attempts
  ]

  @type t :: %__MODULE__{
          uniques: [Torngen.Client.Schema.UserCrimeUniques.t()],
          skill: integer(),
          rewards: Torngen.Client.Schema.UserCrimeRewards.t(),
          progression_bonus: integer(),
          nerve_spent: integer(),
          miscellaneous:
            nil
            | Torngen.Client.Schema.UserCrimeDetailsScamming.t()
            | Torngen.Client.Schema.UserCrimeDetailsCracking.t()
            | Torngen.Client.Schema.UserCrimeDetailsHustling.t()
            | Torngen.Client.Schema.UserCrimeDetailsCardSkimming.t()
            | Torngen.Client.Schema.UserCrimeDetailsShoplifting.t()
            | Torngen.Client.Schema.UserCrimeDetailsGraffiti.t()
            | Torngen.Client.Schema.UserCrimeDetailsBootlegging.t(),
          attempts: Torngen.Client.Schema.UserCrimeAttempts.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uniques:
        data |> Map.get("uniques") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserCrimeUniques}),
      skill: data |> Map.get("skill") |> Torngen.Client.Schema.parse({:static, :integer}),
      rewards: data |> Map.get("rewards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeRewards),
      progression_bonus: data |> Map.get("progression_bonus") |> Torngen.Client.Schema.parse({:static, :integer}),
      nerve_spent: data |> Map.get("nerve_spent") |> Torngen.Client.Schema.parse({:static, :integer}),
      miscellaneous:
        data
        |> Map.get("miscellaneous")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             {:static, :null},
             Torngen.Client.Schema.UserCrimeDetailsScamming,
             Torngen.Client.Schema.UserCrimeDetailsCracking,
             Torngen.Client.Schema.UserCrimeDetailsHustling,
             Torngen.Client.Schema.UserCrimeDetailsCardSkimming,
             Torngen.Client.Schema.UserCrimeDetailsShoplifting,
             Torngen.Client.Schema.UserCrimeDetailsGraffiti,
             Torngen.Client.Schema.UserCrimeDetailsBootlegging
           ]}
        ),
      attempts: data |> Map.get("attempts") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeAttempts)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:uniques, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserCrimeUniques})
  end

  defp validate_key?(:skill, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:rewards, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserCrimeRewards)
  end

  defp validate_key?(:progression_bonus, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:nerve_spent, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:miscellaneous, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         {:static, :null},
         Torngen.Client.Schema.UserCrimeDetailsScamming,
         Torngen.Client.Schema.UserCrimeDetailsCracking,
         Torngen.Client.Schema.UserCrimeDetailsHustling,
         Torngen.Client.Schema.UserCrimeDetailsCardSkimming,
         Torngen.Client.Schema.UserCrimeDetailsShoplifting,
         Torngen.Client.Schema.UserCrimeDetailsGraffiti,
         Torngen.Client.Schema.UserCrimeDetailsBootlegging
       ]}
    )
  end

  defp validate_key?(:attempts, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserCrimeAttempts)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
