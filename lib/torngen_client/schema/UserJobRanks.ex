defmodule Torngen.Client.Schema.UserJobRanks do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :medical,
    :law,
    :grocer,
    :education,
    :casino,
    :army
  ]

  @type t :: %__MODULE__{
          medical: Torngen.Client.Schema.JobPositionMedicalEnum.t(),
          law: Torngen.Client.Schema.JobPositionLawEnum.t(),
          grocer: Torngen.Client.Schema.JobPositionGrocerEnum.t(),
          education: Torngen.Client.Schema.JobPositionEducationEnum.t(),
          casino: Torngen.Client.Schema.JobPositionCasinoEnum.t(),
          army: Torngen.Client.Schema.JobPositionArmyEnum.t()
        }
end
