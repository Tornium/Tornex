defmodule Torngen.Client.Schema.PersonalStatsJobsExtended do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

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
end
