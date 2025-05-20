defmodule Torngen.Client.Schema.TornEducationRewards do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:working_stats, :honor, :effect]

  defstruct [
    :working_stats,
    :honor,
    :effect
  ]

  @type t :: %__MODULE__{
          working_stats: %{
            :manual_labor => nil | integer(),
            :intelligence => nil | integer(),
            :endurance => nil | integer()
          },
          honor: nil | String.t(),
          effect: nil | String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      working_stats:
        Map.get(data, "working_stats")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "endurance" => {:one_of, [static: :null, static: :integer]},
             "intelligence" => {:one_of, [static: :null, static: :integer]},
             "manual_labor" => {:one_of, [static: :null, static: :integer]}
           }}
        ),
      honor: Map.get(data, "honor") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      effect: Map.get(data, "effect") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]})
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

  defp validate_key(:working_stats, value) do
    Torngen.Client.Schema.validate(
      value,
      {:object,
       %{
         "endurance" => {:one_of, [static: :null, static: :integer]},
         "intelligence" => {:one_of, [static: :null, static: :integer]},
         "manual_labor" => {:one_of, [static: :null, static: :integer]}
       }}
    )
  end

  defp validate_key(:honor, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key(:effect, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :string]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
