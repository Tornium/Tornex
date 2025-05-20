defmodule Torngen.Client.Schema.PersonalStatsTrading do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:trading]

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
            :item_market => %{:sales => integer(), :revenue => integer(), :fees => integer(), :customers => integer()},
            :bazaar => %{:sales => integer(), :profit => integer(), :customers => integer()}
          }
        }

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
             "item_market" =>
               {:object,
                %{
                  "customers" => {:static, :integer},
                  "fees" => {:static, :integer},
                  "revenue" => {:static, :integer},
                  "sales" => {:static, :integer}
                }},
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

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:trading, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "bazaar" =>
           {:object,
            %{"customers" => {:static, :integer}, "profit" => {:static, :integer}, "sales" => {:static, :integer}}},
         "item_market" =>
           {:object,
            %{
              "customers" => {:static, :integer},
              "fees" => {:static, :integer},
              "revenue" => {:static, :integer},
              "sales" => {:static, :integer}
            }},
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
