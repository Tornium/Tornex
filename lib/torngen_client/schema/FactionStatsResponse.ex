defmodule Torngen.Client.Schema.FactionStatsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :stats
  ]

  @type t :: %__MODULE__{
          stats: [Torngen.Client.Schema.FactionStat.t()]
        }
end
