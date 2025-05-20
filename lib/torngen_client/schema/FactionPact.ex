defmodule Torngen.Client.Schema.FactionPact do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:until, :faction_name, :faction_id]

  defstruct [
    :until,
    :faction_name,
    :faction_id
  ]

  @type t :: %__MODULE__{
          until: String.t(),
          faction_name: String.t(),
          faction_id: Torngen.Client.Schema.FactionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: data |> Map.get("until") |> Torngen.Client.Schema.parse({:static, :string}),
      faction_name: data |> Map.get("faction_name") |> Torngen.Client.Schema.parse({:static, :string}),
      faction_id: data |> Map.get("faction_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:until, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:faction_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:faction_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
