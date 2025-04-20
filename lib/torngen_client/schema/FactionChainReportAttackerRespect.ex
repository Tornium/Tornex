defmodule Torngen.Client.Schema.FactionChainReportAttackerRespect do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :best,
    :average
  ]

  @type t :: %__MODULE__{
          total: integer() | float(),
          best: integer() | float(),
          average: integer() | float()
        }
end
