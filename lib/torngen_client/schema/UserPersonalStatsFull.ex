defmodule Torngen.Client.Schema.UserPersonalStatsFull do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :personalstats
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          personalstats: [
            Torngen.Client.Schema.PersonalStatsOther.t()
            | Torngen.Client.Schema.PersonalStatsNetworthExtended.t()
            | Torngen.Client.Schema.PersonalStatsRacing.t()
            | Torngen.Client.Schema.PersonalStatsMissions.t()
            | Torngen.Client.Schema.PersonalStatsDrugs.t()
            | Torngen.Client.Schema.PersonalStatsTravel.t()
            | Torngen.Client.Schema.PersonalStatsItems.t()
            | Torngen.Client.Schema.PersonalStatsInvestments.t()
            | Torngen.Client.Schema.PersonalStatsBounties.t()
            | Torngen.Client.Schema.PersonalStatsCrimes.t()
            | Torngen.Client.Schema.PersonalStatsCommunication.t()
            | Torngen.Client.Schema.PersonalStatsFinishingHits.t()
            | Torngen.Client.Schema.PersonalStatsHospital.t()
            | Torngen.Client.Schema.PersonalStatsJail.t()
            | Torngen.Client.Schema.PersonalStatsTrading.t()
            | Torngen.Client.Schema.PersonalStatsJobsExtended.t()
            | Torngen.Client.Schema.PersonalStatsBattleStats.t()
            | Torngen.Client.Schema.PersonalStatsAttackingExtended.t()
          ]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      personalstats: Map.get(data, "personalstats")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
