defmodule Torngen.Client.Schema.TornEducationRewards do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :working_stats,
    :honor,
    :effect
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          working_stats: %{
            :manual_labor => nil | integer(),
            :intelligence => nil | integer(),
            :endurance => nil | integer()
          },
          honor: nil | String.t(),
          effect: nil | String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

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
end
