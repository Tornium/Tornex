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

  @type t :: %__MODULE__{
          uniques: [Torngen.Client.Schema.UserCrimeUniques.t()],
          skill: integer(),
          rewards: Torngen.Client.Schema.UserCrimeRewards.t(),
          progression_bonus: integer(),
          nerve_spent: integer(),
          miscellaneous:
            Torngen.Client.Schema.UserCrimeDetailsScamming.t()
            | Torngen.Client.Schema.UserCrimeDetailsCracking.t()
            | Torngen.Client.Schema.UserCrimeDetailsHustling.t()
            | Torngen.Client.Schema.UserCrimeDetailsCardSkimming.t()
            | Torngen.Client.Schema.UserCrimeDetailsShoplifting.t()
            | Torngen.Client.Schema.UserCrimeDetailsGraffiti.t()
            | Torngen.Client.Schema.UserCrimeDetailsBootlegging.t(),
          attempts: Torngen.Client.Schema.UserCrimeAttempts.t()
        }
end
