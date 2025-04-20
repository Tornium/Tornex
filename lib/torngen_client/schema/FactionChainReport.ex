defmodule Torngen.Client.Schema.FactionChainReport do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :start,
    :"non-attackers",
    :id,
    :faction_id,
    :end,
    :details,
    :bonuses,
    :attackers
  ]

  @type t :: %__MODULE__{
          start: integer(),
          "non-attackers": [Torngen.Client.Schema.UserId.t()],
          id: Torngen.Client.Schema.ChainId.t(),
          faction_id: Torngen.Client.Schema.FactionId.t(),
          end: integer(),
          details: Torngen.Client.Schema.FactionChainReportDetails.t(),
          bonuses: [Torngen.Client.Schema.FactionChainReportBonus.t()],
          attackers: [Torngen.Client.Schema.FactionChainReportAttacker.t()]
        }
end
