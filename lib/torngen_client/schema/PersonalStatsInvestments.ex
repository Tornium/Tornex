defmodule Torngen.Client.Schema.PersonalStatsInvestments do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :investments
  ]

  @type t :: %__MODULE__{
          investments: %{
            :stocks => %{
              :profits => integer(),
              :payouts => integer(),
              :net_profits => integer(),
              :losses => integer(),
              :fees => integer()
            },
            :bank => %{:total => integer(), :time_remaining => integer(), :profit => integer(), :current => integer()}
          }
        }
end
