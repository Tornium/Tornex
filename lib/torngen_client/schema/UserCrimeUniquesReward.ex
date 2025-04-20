defmodule Torngen.Client.Schema.UserCrimeUniquesReward do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :money,
    :items,
    :ammo
  ]

  @type t :: %__MODULE__{
          money: nil | Torngen.Client.Schema.UserCrimeUniquesRewardMoney.t(),
          items: [Torngen.Client.Schema.UserCrimeRewardItem.t()],
          ammo: nil | Torngen.Client.Schema.UserCrimeUniquesRewardAmmo.t()
        }
end
