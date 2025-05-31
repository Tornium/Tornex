defmodule Torngen.Client.Schema.FactionMember do
  @moduledoc false

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
      status: data |> Map.get("status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserStatus),
      revive_setting:
        data |> Map.get("revive_setting") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReviveSetting),
      position: data |> Map.get("position") |> Torngen.Client.Schema.parse({:static, :string}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_action: data |> Map.get("last_action") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserLastAction),
      is_revivable: data |> Map.get("is_revivable") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_on_wall: data |> Map.get("is_on_wall") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_in_oc: data |> Map.get("is_in_oc") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      has_early_discharge: data |> Map.get("has_early_discharge") |> Torngen.Client.Schema.parse({:static, :boolean}),
      days_in_faction: data |> Map.get("days_in_faction") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def parse(_data), do: nil

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
