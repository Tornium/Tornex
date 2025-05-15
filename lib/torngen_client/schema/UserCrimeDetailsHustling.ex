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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          total_audience_gathered: integer(),
          shill_money_collected: integer(),
          pickpocket_money_collected: integer(),
          biggest_money_won: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total_audience_gathered: Map.get(data, "total_audience_gathered"),
      shill_money_collected: Map.get(data, "shill_money_collected"),
      pickpocket_money_collected: Map.get(data, "pickpocket_money_collected"),
      biggest_money_won: Map.get(data, "biggest_money_won")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
