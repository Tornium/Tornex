defmodule Torngen.Client.Schema.FactionMember do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      status: Map.get(data, "status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserStatus),
      revive_setting:
        Map.get(data, "revive_setting") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReviveSetting),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:static, :string}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      life: Map.get(data, "life") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserLife),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_action: Map.get(data, "last_action") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserLastAction),
      is_revivable: Map.get(data, "is_revivable") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_on_wall: Map.get(data, "is_on_wall") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_in_oc: Map.get(data, "is_in_oc") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      has_early_discharge: Map.get(data, "has_early_discharge") |> Torngen.Client.Schema.parse({:static, :boolean}),
      days_in_faction: Map.get(data, "days_in_faction") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
