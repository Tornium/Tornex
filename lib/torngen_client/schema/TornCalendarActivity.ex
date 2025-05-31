defmodule Torngen.Client.Schema.TornCalendarActivity do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:title, :start, :end, :description]

  defstruct [
    :title,
    :start,
    :end,
    :description
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          start: integer(),
          end: integer(),
          description: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: data |> Map.get("title") |> Torngen.Client.Schema.parse({:static, :string}),
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :integer}),
      description: data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
