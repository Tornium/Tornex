defmodule Torngen.Client.Schema.FactionCrimeSlot do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :user_id,
    :user,
    :success_chance,
    :position,
    :item_requirement,
    :crime_pass_rate,
    :checkpoint_pass_rate
  ]

  @type t :: %__MODULE__{
          user_id: nil | Torngen.Client.Schema.UserId.t(),
          user: nil | Torngen.Client.Schema.FactionCrimeUser.t(),
          success_chance: integer(),
          position: String.t(),
          item_requirement:
            nil | %{:is_reusable => boolean(), :is_available => boolean(), :id => Torngen.Client.Schema.ItemId.t()},
          crime_pass_rate: integer(),
          checkpoint_pass_rate: integer()
        }
end
