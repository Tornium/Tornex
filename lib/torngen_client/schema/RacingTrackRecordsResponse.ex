defmodule Torngen.Client.Schema.RacingTrackRecordsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :records
  ]

  @type t :: %__MODULE__{
          records: [Torngen.Client.Schema.RaceRecord.t()]
        }
end
