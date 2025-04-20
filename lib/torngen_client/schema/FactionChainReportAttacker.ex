defmodule Torngen.Client.Schema.FactionChainReportAttacker do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :id,
    :attacks
  ]

  @type t :: %__MODULE__{
          respect: Torngen.Client.Schema.FactionChainReportAttackerRespect.t(),
          id: Torngen.Client.Schema.UserId.t(),
          attacks: Torngen.Client.Schema.FactionChainReportAttackerAttacks.t()
        }
end
