defmodule Torngen.Client.Schema.UserCrimeUniquesReward do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :money,
    :items,
    :ammo
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          money: nil | Torngen.Client.Schema.UserCrimeUniquesRewardMoney.t(),
          items: [Torngen.Client.Schema.UserCrimeRewardItem.t()],
          ammo: nil | Torngen.Client.Schema.UserCrimeUniquesRewardAmmo.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      money:
        Map.get(data, "money")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserCrimeUniquesRewardMoney]}),
      items: Map.get(data, "items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserCrimeRewardItem}),
      ammo:
        Map.get(data, "ammo")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserCrimeUniquesRewardAmmo]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
