defmodule Torngen.Client.Schema.FactionCrimeRewardPayout do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :type,
    :percentage,
    :paid_by,
    :paid_at
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.FactionOrganizedCrimePayoutType.t(),
          percentage: integer(),
          paid_by: Torngen.Client.Schema.UserId.t(),
          paid_at: integer()
        }
end
