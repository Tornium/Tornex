defmodule Torngen.Client.Schema.FactionCrime do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :status,
    :slots,
    :rewards,
    :ready_at,
    :planning_at,
    :name,
    :id,
    :expired_at,
    :executed_at,
    :difficulty,
    :created_at
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.FactionCrimeStatusEnum.t(),
          slots: [Torngen.Client.Schema.FactionCrimeSlot.t()],
          rewards: nil | Torngen.Client.Schema.FactionCrimeReward.t(),
          ready_at: nil | integer(),
          planning_at: nil | integer(),
          name: String.t(),
          id: Torngen.Client.Schema.FactionCrimeId.t(),
          expired_at: integer(),
          executed_at: nil | integer(),
          difficulty: integer(),
          created_at: integer()
        }
end
