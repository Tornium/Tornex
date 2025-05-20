defmodule Torngen.Client.Schema.PersonalStatsInvestments do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :investments
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      investments:
        Map.get(data, "investments")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "bank" =>
               {:object,
                %{
                  "current" => {:static, :integer},
                  "profit" => {:static, :integer},
                  "time_remaining" => {:static, :integer},
                  "total" => {:static, :integer}
                }},
             "stocks" =>
               {:object,
                %{
                  "fees" => {:static, :integer},
                  "losses" => {:static, :integer},
                  "net_profits" => {:static, :integer},
                  "payouts" => {:static, :integer},
                  "profits" => {:static, :integer}
                }}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
