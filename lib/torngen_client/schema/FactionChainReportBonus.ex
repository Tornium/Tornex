defmodule Torngen.Client.Schema.FactionChainReportBonus do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :defender_id,
    :chain,
    :attacker_id
  ]

  @type t :: %__MODULE__{
          respect: integer(),
          defender_id: Torngen.Client.Schema.UserId.t(),
          chain: integer(),
          attacker_id: Torngen.Client.Schema.UserId.t()
        }
end
