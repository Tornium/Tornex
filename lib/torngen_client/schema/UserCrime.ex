defmodule Torngen.Client.Schema.UserCrime do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :uniques,
    :skill,
    :rewards,
    :progression_bonus,
    :nerve_spent,
    :miscellaneous,
    :attempts
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uniques:
        Map.get(data, "uniques") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserCrimeUniques}),
      skill: Map.get(data, "skill") |> Torngen.Client.Schema.parse({:static, :integer}),
      rewards: Map.get(data, "rewards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeRewards),
      progression_bonus: Map.get(data, "progression_bonus") |> Torngen.Client.Schema.parse({:static, :integer}),
      nerve_spent: Map.get(data, "nerve_spent") |> Torngen.Client.Schema.parse({:static, :integer}),
      miscellaneous:
        Map.get(data, "miscellaneous")
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
      attempts: Map.get(data, "attempts") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeAttempts)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
