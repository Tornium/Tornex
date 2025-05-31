defmodule Torngen.Client.Schema.UserPersonalStatsPopular do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:personalstats]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      personalstats:
        data
        |> Map.get("personalstats")
        |> Torngen.Client.Schema.parse(
          {:all_of,
           [
             Torngen.Client.Schema.PersonalStatsOtherPopular,
             Torngen.Client.Schema.PersonalStatsNetworthPublic,
             Torngen.Client.Schema.PersonalStatsDrugs,
             Torngen.Client.Schema.PersonalStatsTravelPopular,
             Torngen.Client.Schema.PersonalStatsItemsPopular,
             Torngen.Client.Schema.PersonalStatsCrimesPopular,
             Torngen.Client.Schema.PersonalStatsHospitalPopular,
             Torngen.Client.Schema.PersonalStatsJobsPublic,
             Torngen.Client.Schema.PersonalStatsAttackingPopular
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
      {:all_of,
       [
         Torngen.Client.Schema.PersonalStatsOtherPopular,
         Torngen.Client.Schema.PersonalStatsNetworthPublic,
         Torngen.Client.Schema.PersonalStatsDrugs,
         Torngen.Client.Schema.PersonalStatsTravelPopular,
         Torngen.Client.Schema.PersonalStatsItemsPopular,
         Torngen.Client.Schema.PersonalStatsCrimesPopular,
         Torngen.Client.Schema.PersonalStatsHospitalPopular,
         Torngen.Client.Schema.PersonalStatsJobsPublic,
         Torngen.Client.Schema.PersonalStatsAttackingPopular
       ]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
