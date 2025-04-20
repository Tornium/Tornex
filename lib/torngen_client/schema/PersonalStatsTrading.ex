defmodule Torngen.Client.Schema.PersonalStatsTrading do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :trading
  ]

  @type t :: %__MODULE__{
          trading: %{
            :trades => integer(),
            :points => %{:sold => integer(), :bought => integer()},
            :items => %{
              :sent => integer(),
              :bought => %{:shops => integer(), :market => integer()},
              :auctions => %{:won => integer(), :sold => integer()}
            },
            :bazaar => %{:sales => integer(), :profit => integer(), :customers => integer()}
          }
        }
end
