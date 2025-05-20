defmodule Torngen.Client.Schema.PersonalStatsJobsPublic do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      jobs:
        Map.get(data, "jobs")
        |> Torngen.Client.Schema.parse(
          {:object, %{"job_points_used" => {:static, :integer}, "trains_received" => {:static, :integer}}}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
