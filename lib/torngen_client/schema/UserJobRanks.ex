defmodule Torngen.Client.Schema.UserJobRanks do
  @moduledoc """
  [SHORT DESCRIPTION]
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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          medical: Torngen.Client.Schema.JobPositionMedicalEnum.t(),
          law: Torngen.Client.Schema.JobPositionLawEnum.t(),
          grocer: Torngen.Client.Schema.JobPositionGrocerEnum.t(),
          education: Torngen.Client.Schema.JobPositionEducationEnum.t(),
          casino: Torngen.Client.Schema.JobPositionCasinoEnum.t(),
          army: Torngen.Client.Schema.JobPositionArmyEnum.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      medical: Map.get(data, "medical") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionMedicalEnum),
      law: Map.get(data, "law") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionLawEnum),
      grocer: Map.get(data, "grocer") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionGrocerEnum),
      education:
        Map.get(data, "education") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionEducationEnum),
      casino: Map.get(data, "casino") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionCasinoEnum),
      army: Map.get(data, "army") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionArmyEnum)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
