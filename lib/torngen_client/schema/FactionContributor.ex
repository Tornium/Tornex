defmodule Torngen.Client.Schema.FactionContributor do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:value, :username, :in_faction, :id]

  defstruct [
    :value,
    :username,
    :in_faction,
    :id
  ]

  @type t :: %__MODULE__{
          value: integer(),
          username: String.t(),
          in_faction: boolean(),
          id: Torngen.Client.Schema.UserId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value") |> Torngen.Client.Schema.parse({:static, :integer}),
      username: Map.get(data, "username") |> Torngen.Client.Schema.parse({:static, :string}),
      in_faction: Map.get(data, "in_faction") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
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

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:username, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:in_faction, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
