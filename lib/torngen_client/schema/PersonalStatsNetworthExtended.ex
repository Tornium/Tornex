defmodule Torngen.Client.Schema.PersonalStatsNetworthExtended do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :networth
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      networth: Map.get(data, "networth")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
