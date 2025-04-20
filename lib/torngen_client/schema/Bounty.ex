defmodule Torngen.Client.Schema.Bounty do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :valid_until,
    :target_name,
    :target_level,
    :target_id,
    :reward,
    :reason,
    :quantity,
    :lister_name,
    :lister_id,
    :is_anonymous
  ]

  @type t :: %__MODULE__{
          valid_until: integer(),
          target_name: String.t(),
          target_level: integer(),
          target_id: Torngen.Client.Schema.UserId.t(),
          reward: integer(),
          reason: nil | String.t(),
          quantity: integer(),
          lister_name: nil | String.t(),
          lister_id: nil | Torngen.Client.Schema.UserId.t(),
          is_anonymous: boolean()
        }
end
