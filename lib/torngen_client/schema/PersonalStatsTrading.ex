defmodule Torngen.Client.Schema.PersonalStatsTrading do
  @moduledoc """
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
      trading: Map.get(data, "trading")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
