defmodule Torngen.Client.Schema.UserCrimeDetailsHustling do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total_audience_gathered,
    :shill_money_collected,
    :pickpocket_money_collected,
    :biggest_money_won
  ]

  @type t :: %__MODULE__{
          total_audience_gathered: integer(),
          shill_money_collected: integer(),
          pickpocket_money_collected: integer(),
          biggest_money_won: integer()
        }
end
