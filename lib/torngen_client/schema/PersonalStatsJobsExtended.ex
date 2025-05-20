defmodule Torngen.Client.Schema.PersonalStatsJobsExtended do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:jobs]

  defstruct [
    :jobs
  ]

  @type t :: %__MODULE__{
          jobs: %{
            :trains_received => integer(),
            :stats => %{:total => integer(), :manual => integer(), :intelligence => integer(), :endurance => integer()},
            :job_points_used => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jobs:
        Map.get(data, "jobs")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "job_points_used" => {:static, :integer},
             "stats" =>
               {:object,
                %{
                  "endurance" => {:static, :integer},
                  "intelligence" => {:static, :integer},
                  "manual" => {:static, :integer},
                  "total" => {:static, :integer}
                }},
             "trains_received" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:jobs, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "job_points_used" => {:static, :integer},
         "stats" =>
           {:object,
            %{
              "endurance" => {:static, :integer},
              "intelligence" => {:static, :integer},
              "manual" => {:static, :integer},
              "total" => {:static, :integer}
            }},
         "trains_received" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
