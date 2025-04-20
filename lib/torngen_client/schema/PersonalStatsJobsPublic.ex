defmodule Torngen.Client.Schema.PersonalStatsJobsPublic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :jobs
  ]

  @type t :: %__MODULE__{
          jobs: %{:trains_received => integer(), :job_points_used => integer()}
        }
end
