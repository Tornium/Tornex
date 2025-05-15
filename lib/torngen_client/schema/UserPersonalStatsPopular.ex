defmodule Torngen.Client.Schema.UserPersonalStatsPopular do
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
