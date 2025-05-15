defmodule Torngen.Client.Schema.UserCrime do
  @moduledoc """
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
      uniques: Map.get(data, "uniques"),
      skill: Map.get(data, "skill"),
      rewards: Map.get(data, "rewards"),
      progression_bonus: Map.get(data, "progression_bonus"),
      nerve_spent: Map.get(data, "nerve_spent"),
      miscellaneous: Map.get(data, "miscellaneous"),
      attempts: Map.get(data, "attempts")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
