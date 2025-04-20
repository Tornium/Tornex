defmodule Torngen.Client.Schema.UserCrimeAttempts do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :success,
    :subcrimes,
    :fail,
    :critical_fail
  ]

  @type t :: %__MODULE__{
          total: integer(),
          success: integer(),
          subcrimes: [Torngen.Client.Schema.UserSubcrime.t()],
          fail: integer(),
          critical_fail: integer()
        }
end
