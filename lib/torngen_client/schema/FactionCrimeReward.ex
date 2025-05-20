defmodule Torngen.Client.Schema.FactionCrimeReward do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      scope: Map.get(data, "scope") |> Torngen.Client.Schema.parse({:static, :integer}),
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      payout:
        Map.get(data, "payout")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeRewardPayout]}),
      money: Map.get(data, "money") |> Torngen.Client.Schema.parse({:static, :integer}),
      items:
        Map.get(data, "items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionCrimeRewardItem})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
