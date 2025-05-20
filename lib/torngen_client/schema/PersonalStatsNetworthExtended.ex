defmodule Torngen.Client.Schema.PersonalStatsNetworthExtended do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      networth:
        Map.get(data, "networth")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "auction_house" => {:static, :integer},
             "bank" => {:static, :integer},
             "bazaar" => {:static, :integer},
             "bookie" => {:static, :integer},
             "company" => {:static, :integer},
             "display_case" => {:static, :integer},
             "enlisted_cars" => {:static, :integer},
             "inventory" => {:static, :integer},
             "item_market" => {:static, :integer},
             "loans" => {:static, :integer},
             "overseas_bank" => {:static, :integer},
             "pending" => {:static, :integer},
             "piggy_bank" => {:static, :integer},
             "points" => {:static, :integer},
             "property" => {:static, :integer},
             "stock_market" => {:static, :integer},
             "total" => {:static, :integer},
             "unpaid_fees" => {:static, :integer},
             "vaults" => {:static, :integer},
             "wallet" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
