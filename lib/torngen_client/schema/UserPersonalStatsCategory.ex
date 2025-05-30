defmodule Torngen.Client.Schema.UserPersonalStatsCategory do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:personalstats]

  defstruct [
    :personalstats
  ]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      personalstats:
        data
        |> Map.get("personalstats")
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
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:personalstats, value) do
    Torngen.Client.Schema.validate?(
      value,
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
