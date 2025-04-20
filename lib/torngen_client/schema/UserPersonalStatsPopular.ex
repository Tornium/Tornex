defmodule Torngen.Client.Schema.UserPersonalStatsPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :personalstats
  ]

  @type t :: %__MODULE__{
          personalstats: [
            Torngen.Client.Schema.PersonalStatsOtherPopular.t()
            | Torngen.Client.Schema.PersonalStatsNetworthPublic.t()
            | Torngen.Client.Schema.PersonalStatsDrugs.t()
            | Torngen.Client.Schema.PersonalStatsTravelPopular.t()
            | Torngen.Client.Schema.PersonalStatsItemsPopular.t()
            | Torngen.Client.Schema.PersonalStatsCrimesPopular.t()
            | Torngen.Client.Schema.PersonalStatsHospitalPopular.t()
            | Torngen.Client.Schema.PersonalStatsJobsPublic.t()
            | Torngen.Client.Schema.PersonalStatsAttackingPopular.t()
          ]
        }
end
