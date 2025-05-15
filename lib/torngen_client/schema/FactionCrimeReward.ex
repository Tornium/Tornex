defmodule Torngen.Client.Schema.FactionCrimeReward do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :scope,
    :respect,
    :payout,
    :money,
    :items
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          scope: integer(),
          respect: integer(),
          payout: nil | Torngen.Client.Schema.FactionCrimeRewardPayout.t(),
          money: integer(),
          items: [Torngen.Client.Schema.FactionCrimeRewardItem.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      scope: Map.get(data, "scope"),
      respect: Map.get(data, "respect"),
      payout: Map.get(data, "payout"),
      money: Map.get(data, "money"),
      items: Map.get(data, "items")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
