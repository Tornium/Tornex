defmodule Torngen.Client.Schema.PersonalStatsNetworthExtended do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :networth
  ]

  @type t :: %__MODULE__{
          networth: %{
            :wallet => integer(),
            :vaults => integer(),
            :unpaid_fees => integer(),
            :total => integer(),
            :stock_market => integer(),
            :property => integer(),
            :points => integer(),
            :piggy_bank => integer(),
            :pending => integer(),
            :overseas_bank => integer(),
            :loans => integer(),
            :item_market => integer(),
            :inventory => integer(),
            :enlisted_cars => integer(),
            :display_case => integer(),
            :company => integer(),
            :bookie => integer(),
            :bazaar => integer(),
            :bank => integer(),
            :auction_house => integer()
          }
        }
end
