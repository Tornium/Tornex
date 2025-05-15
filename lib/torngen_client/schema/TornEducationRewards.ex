defmodule Torngen.Client.Schema.TornEducationRewards do
  @moduledoc """
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
      working_stats: Map.get(data, "working_stats"),
      honor: Map.get(data, "honor"),
      effect: Map.get(data, "effect")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
