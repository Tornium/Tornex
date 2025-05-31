defmodule Torngen.Client.Schema.TornLog do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:title, :id]

  defstruct [
    :title,
    :id
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          id: Torngen.Client.Schema.LogId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: data |> Map.get("title") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.LogId)
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

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.LogId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
