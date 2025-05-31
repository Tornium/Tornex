defmodule Torngen.Client.Schema.ReportFriendOrFoe do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:friends, :enemies]

  defstruct [
    :friends,
    :enemies
  ]

  @type t :: %__MODULE__{
          friends: [Torngen.Client.Schema.ReportFriendOrFoeUser.t()],
          enemies: [Torngen.Client.Schema.ReportFriendOrFoeUser.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      friends:
        data |> Map.get("friends") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ReportFriendOrFoeUser}),
      enemies:
        data |> Map.get("enemies") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ReportFriendOrFoeUser})
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

  defp validate_key?(:friends, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ReportFriendOrFoeUser})
  end

  defp validate_key?(:enemies, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ReportFriendOrFoeUser})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
