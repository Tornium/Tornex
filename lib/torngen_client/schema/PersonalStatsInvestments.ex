defmodule Torngen.Client.Schema.PersonalStatsInvestments do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:investments]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      investments:
        data
        |> Map.get("investments")
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
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:investments, value) do
    Torngen.Client.Schema.validate?(
      value,
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
