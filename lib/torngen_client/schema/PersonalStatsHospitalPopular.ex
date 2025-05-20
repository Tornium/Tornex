defmodule Torngen.Client.Schema.PersonalStatsHospitalPopular do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:hospital]

  defstruct [
    :hospital
  ]

  @type t :: %__MODULE__{
          hospital: %{:reviving => %{:skill => integer(), :revives => integer()}, :medical_items_used => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hospital:
        Map.get(data, "hospital")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "medical_items_used" => {:static, :integer},
             "reviving" => {:object, %{"revives" => {:static, :integer}, "skill" => {:static, :integer}}}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:hospital, value) do
    Torngen.Client.Schema.validate(
      value,
      {:object,
       %{
         "medical_items_used" => {:static, :integer},
         "reviving" => {:object, %{"revives" => {:static, :integer}, "skill" => {:static, :integer}}}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
