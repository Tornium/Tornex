defmodule Torngen.Client.Schema.FactionMember do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :status,
    :revive_setting,
    :position,
    :name,
    :life,
    :level,
    :last_action,
    :is_revivable,
    :is_on_wall,
    :is_in_oc,
    :id,
    :has_early_discharge,
    :days_in_faction
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserStatus.t(),
          revive_setting: Torngen.Client.Schema.ReviveSetting.t(),
          position: String.t(),
          name: String.t(),
          life: Torngen.Client.Schema.UserLife.t(),
          level: integer(),
          last_action: Torngen.Client.Schema.UserLastAction.t(),
          is_revivable: boolean(),
          is_on_wall: boolean(),
          is_in_oc: boolean(),
          id: Torngen.Client.Schema.UserId.t(),
          has_early_discharge: boolean(),
          days_in_faction: integer()
        }
end
