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
      medical: Map.get(data, "medical"),
      law: Map.get(data, "law"),
      grocer: Map.get(data, "grocer"),
      education: Map.get(data, "education"),
      casino: Map.get(data, "casino"),
      army: Map.get(data, "army")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
