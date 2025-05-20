defmodule Torngen.Client.Schema.FactionMember do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :status,
    :revive_setting,
    :position,
    :name,
    :level,
    :last_action,
    :is_revivable,
    :is_on_wall,
    :is_in_oc,
    :id,
    :has_early_discharge,
    :days_in_faction
  ]

  defstruct [
    :status,
    :revive_setting,
    :position,
    :name,
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
          level: integer(),
          last_action: Torngen.Client.Schema.UserLastAction.t(),
          is_revivable: boolean(),
          is_on_wall: boolean(),
          is_in_oc: boolean(),
          id: Torngen.Client.Schema.UserId.t(),
          has_early_discharge: boolean(),
          days_in_faction: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status: Map.get(data, "status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserStatus),
      revive_setting:
        Map.get(data, "revive_setting") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReviveSetting),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:static, :string}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
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

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserStatus)
  end

  defp validate_key?(:revive_setting, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ReviveSetting)
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:last_action, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserLastAction)
  end

  defp validate_key?(:is_revivable, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_on_wall, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_in_oc, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:has_early_discharge, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:days_in_faction, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
