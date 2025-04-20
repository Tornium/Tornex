defmodule Torngen.Client.Schema.UserCrimeRewardAmmo do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :standard,
    :special
  ]

  @type t :: %__MODULE__{
          standard: integer(),
          special: integer()
        }
end
