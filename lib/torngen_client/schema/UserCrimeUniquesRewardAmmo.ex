defmodule Torngen.Client.Schema.UserCrimeUniquesRewardAmmo do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :type,
    :amount
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum.t(),
          amount: integer()
        }
end
