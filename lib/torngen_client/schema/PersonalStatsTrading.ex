defmodule Torngen.Client.Schema.PersonalStatsTrading do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :trading
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      trading:
        Map.get(data, "trading")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "bazaar" =>
               {:object,
                %{"customers" => {:static, :integer}, "profit" => {:static, :integer}, "sales" => {:static, :integer}}},
             "items" =>
               {:object,
                %{
                  "auctions" => {:object, %{"sold" => {:static, :integer}, "won" => {:static, :integer}}},
                  "bought" => {:object, %{"market" => {:static, :integer}, "shops" => {:static, :integer}}},
                  "sent" => {:static, :integer}
                }},
             "points" => {:object, %{"bought" => {:static, :integer}, "sold" => {:static, :integer}}},
             "trades" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
