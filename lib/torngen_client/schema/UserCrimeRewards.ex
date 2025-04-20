defmodule Torngen.Client.Schema.UserCrimeRewards do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :money,
    :items,
    :ammo
  ]

  @type t :: %__MODULE__{
          money: integer(),
          items: [Torngen.Client.Schema.UserCrimeRewardItem.t()],
          ammo: Torngen.Client.Schema.UserCrimeRewardAmmo.t()
        }
end
