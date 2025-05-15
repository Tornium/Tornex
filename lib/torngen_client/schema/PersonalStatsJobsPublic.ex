defmodule Torngen.Client.Schema.PersonalStatsJobsPublic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :jobs
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          jobs: %{:trains_received => integer(), :job_points_used => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jobs: Map.get(data, "jobs")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
