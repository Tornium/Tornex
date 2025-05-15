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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status: Map.get(data, "status"),
      revive_setting: Map.get(data, "revive_setting"),
      position: Map.get(data, "position"),
      name: Map.get(data, "name"),
      life: Map.get(data, "life"),
      level: Map.get(data, "level"),
      last_action: Map.get(data, "last_action"),
      is_revivable: Map.get(data, "is_revivable"),
      is_on_wall: Map.get(data, "is_on_wall"),
      is_in_oc: Map.get(data, "is_in_oc"),
      id: Map.get(data, "id"),
      has_early_discharge: Map.get(data, "has_early_discharge"),
      days_in_faction: Map.get(data, "days_in_faction")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
