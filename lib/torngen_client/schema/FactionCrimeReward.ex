defmodule Torngen.Client.Schema.FactionCrimeReward do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :scope,
    :respect,
    :payout,
    :money,
    :items
  ]

  @type t :: %__MODULE__{
          scope: integer(),
          respect: integer(),
          payout: nil | Torngen.Client.Schema.FactionCrimeRewardPayout.t(),
          money: integer(),
          items: [Torngen.Client.Schema.FactionCrimeRewardItem.t()]
        }
end
