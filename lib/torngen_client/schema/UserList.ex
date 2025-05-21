defmodule Torngen.Client.Schema.UserList do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:status, :name, :level, :last_action, :id, :faction_id]

  defstruct [
    :status,
    :name,
    :level,
    :last_action,
    :id,
    :faction_id
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserStatus.t(),
          name: String.t(),
          level: integer(),
          last_action: Torngen.Client.Schema.UserLastAction.t(),
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status: data |> Map.get("status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserStatus),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_action: data |> Map.get("last_action") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserLastAction),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      faction_id:
        data
        |> Map.get("faction_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
    }
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

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:last_action, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserLastAction)
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:faction_id, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
