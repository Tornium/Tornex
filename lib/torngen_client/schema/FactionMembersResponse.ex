defmodule Torngen.Client.Schema.FactionMembersResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:members]

  defstruct [
    :members
  ]

  @type t :: %__MODULE__{
          members: [Torngen.Client.Schema.FactionMember.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      members: data |> Map.get("members") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionMember})
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

  defp validate_key?(:members, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionMember})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
