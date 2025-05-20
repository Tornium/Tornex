defmodule Torngen.Client.Schema.UserPersonalStatsCategory do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :personalstats
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          personalstats:
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
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      personalstats:
        Map.get(data, "personalstats")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             Torngen.Client.Schema.PersonalStatsOther,
             Torngen.Client.Schema.PersonalStatsNetworthPublic,
             Torngen.Client.Schema.PersonalStatsRacing,
             Torngen.Client.Schema.PersonalStatsMissions,
             Torngen.Client.Schema.PersonalStatsDrugs,
             Torngen.Client.Schema.PersonalStatsTravel,
             Torngen.Client.Schema.PersonalStatsItems,
             Torngen.Client.Schema.PersonalStatsBounties,
             Torngen.Client.Schema.PersonalStatsCrimes,
             Torngen.Client.Schema.PersonalStatsCommunication,
             Torngen.Client.Schema.PersonalStatsFinishingHits,
             Torngen.Client.Schema.PersonalStatsHospital,
             Torngen.Client.Schema.PersonalStatsJail,
             Torngen.Client.Schema.PersonalStatsTrading,
             Torngen.Client.Schema.PersonalStatsJobsPublic,
             Torngen.Client.Schema.PersonalStatsAttackingPublic
           ]}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
