defmodule Torngen.Client.Schema.TornItemArmorDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :coverage,
    :base_stats
  ]

  @type t :: %__MODULE__{
          coverage: [Torngen.Client.Schema.TornItemArmorCoverage.t()],
          base_stats: Torngen.Client.Schema.TornItemBaseStats.t()
        }
end
