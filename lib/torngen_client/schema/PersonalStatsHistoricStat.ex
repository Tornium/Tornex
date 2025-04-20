defmodule Torngen.Client.Schema.PersonalStatsHistoricStat do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :timestamp,
    :name
  ]

  @type t :: %__MODULE__{
          value: integer(),
          timestamp: integer(),
          name: String.t()
        }
end
