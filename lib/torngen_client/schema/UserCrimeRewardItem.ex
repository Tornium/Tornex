defmodule Torngen.Client.Schema.UserCrimeRewardItem do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :id,
    :amount
  ]

  @type t :: %__MODULE__{
          id: integer(),
          amount: integer()
        }
end
