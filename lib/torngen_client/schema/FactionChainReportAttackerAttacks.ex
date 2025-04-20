defmodule Torngen.Client.Schema.FactionChainReportAttackerAttacks do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war,
    :total,
    :retaliations,
    :overseas,
    :mug,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :bonuses,
    :assists
  ]

  @type t :: %__MODULE__{
          war: integer(),
          total: integer(),
          retaliations: integer(),
          overseas: integer(),
          mug: integer(),
          losses: integer(),
          leave: integer(),
          hospitalize: integer(),
          escapes: integer(),
          draws: integer(),
          bonuses: integer(),
          assists: integer()
        }
end
