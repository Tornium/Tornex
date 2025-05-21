defmodule Torngen.Client.Schema.UserJobRanks do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:medical, :law, :grocer, :education, :casino, :army]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      medical: data |> Map.get("medical") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionMedicalEnum),
      law: data |> Map.get("law") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionLawEnum),
      grocer: data |> Map.get("grocer") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionGrocerEnum),
      education:
        data |> Map.get("education") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionEducationEnum),
      casino: data |> Map.get("casino") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionCasinoEnum),
      army: data |> Map.get("army") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.JobPositionArmyEnum)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:medical, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.JobPositionMedicalEnum)
  end

  defp validate_key?(:law, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.JobPositionLawEnum)
  end

  defp validate_key?(:grocer, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.JobPositionGrocerEnum)
  end

  defp validate_key?(:education, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.JobPositionEducationEnum)
  end

  defp validate_key?(:casino, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.JobPositionCasinoEnum)
  end

  defp validate_key?(:army, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.JobPositionArmyEnum)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
