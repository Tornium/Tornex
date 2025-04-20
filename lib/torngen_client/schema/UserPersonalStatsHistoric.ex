defmodule Torngen.Client.Schema.UserPersonalStatsHistoric do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :personalstats
  ]

  @type t :: %__MODULE__{
          personalstats: [Torngen.Client.Schema.PersonalStatsHistoricStat.t()]
        }
end
