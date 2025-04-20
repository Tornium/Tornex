defmodule Torngen.Client.Schema.FactionChainReportDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war,
    :targets,
    :retaliations,
    :respect,
    :overseas,
    :mug,
    :members,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :chain,
    :best,
    :assists
  ]

  @type t :: %__MODULE__{
          war: integer(),
          targets: integer(),
          retaliations: integer(),
          respect: integer() | float(),
          overseas: integer(),
          mug: integer(),
          members: integer(),
          losses: integer(),
          leave: integer(),
          hospitalize: integer(),
          escapes: integer(),
          draws: integer(),
          chain: integer(),
          best: integer() | float(),
          assists: integer()
        }
end
