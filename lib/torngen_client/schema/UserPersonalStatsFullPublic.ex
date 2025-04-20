defmodule Torngen.Client.Schema.UserPersonalStatsFullPublic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :personalstats
  ]

  @type t :: %__MODULE__{
          personalstats: [
            Torngen.Client.Schema.PersonalStatsOther.t()
            | Torngen.Client.Schema.PersonalStatsNetworthPublic.t()
            | Torngen.Client.Schema.PersonalStatsRacing.t()
            | Torngen.Client.Schema.PersonalStatsMissions.t()
            | Torngen.Client.Schema.PersonalStatsDrugs.t()
            | Torngen.Client.Schema.PersonalStatsTravel.t()
            | Torngen.Client.Schema.PersonalStatsItems.t()
            | Torngen.Client.Schema.PersonalStatsBounties.t()
            | Torngen.Client.Schema.PersonalStatsCrimes.t()
            | Torngen.Client.Schema.PersonalStatsCommunication.t()
            | Torngen.Client.Schema.PersonalStatsFinishingHits.t()
            | Torngen.Client.Schema.PersonalStatsHospital.t()
            | Torngen.Client.Schema.PersonalStatsJail.t()
            | Torngen.Client.Schema.PersonalStatsTrading.t()
            | Torngen.Client.Schema.PersonalStatsJobsPublic.t()
            | Torngen.Client.Schema.PersonalStatsAttackingPublic.t()
          ]
        }
end
