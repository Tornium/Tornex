defmodule Torngen.Client.Schema.TornHof do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :value,
    :username,
    :signed_up,
    :rank_number,
    :rank_name,
    :rank,
    :position,
    :level,
    :last_action,
    :id,
    :faction_id,
    :age_in_days
  ]

  defstruct [
    :value,
    :username,
    :signed_up,
    :rank_number,
    :rank_name,
    :rank,
    :position,
    :level,
    :last_action,
    :id,
    :faction_id,
    :age_in_days
  ]

  @type t :: %__MODULE__{
          value: term(),
          username: String.t(),
          signed_up: integer(),
          rank_number: integer(),
          rank_name: String.t(),
          rank: String.t(),
          position: integer(),
          level: integer(),
          last_action: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: Torngen.Client.Schema.FactionId.t(),
          age_in_days: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: data |> Map.get("value") |> Torngen.Client.Schema.parse(:any),
      username: data |> Map.get("username") |> Torngen.Client.Schema.parse({:static, :string}),
      signed_up: data |> Map.get("signed_up") |> Torngen.Client.Schema.parse({:static, :integer}),
      rank_number: data |> Map.get("rank_number") |> Torngen.Client.Schema.parse({:static, :integer}),
      rank_name: data |> Map.get("rank_name") |> Torngen.Client.Schema.parse({:static, :string}),
      rank: data |> Map.get("rank") |> Torngen.Client.Schema.parse({:static, :string}),
      position: data |> Map.get("position") |> Torngen.Client.Schema.parse({:static, :integer}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_action: data |> Map.get("last_action") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      faction_id: data |> Map.get("faction_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      age_in_days: data |> Map.get("age_in_days") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(value, :any)
  end

  defp validate_key?(:username, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:signed_up, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:rank_number, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:rank_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:rank, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:last_action, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:faction_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key?(:age_in_days, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
