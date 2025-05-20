defmodule Torngen.Client.Schema.UserCrimeRewards do
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
          money: integer(),
          items: [Torngen.Client.Schema.UserCrimeRewardItem.t()],
          ammo: Torngen.Client.Schema.UserCrimeRewardAmmo.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      money: Map.get(data, "money") |> Torngen.Client.Schema.parse({:static, :integer}),
      items: Map.get(data, "items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserCrimeRewardItem}),
      ammo: Map.get(data, "ammo") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeRewardAmmo)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
