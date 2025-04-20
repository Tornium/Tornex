defmodule Torngen.Client.Schema.UserCrimeUniquesRewardMoney do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :min,
    :max
  ]

  @type t :: %__MODULE__{
          min: integer(),
          max: integer()
        }
end
