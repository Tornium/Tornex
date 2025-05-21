defmodule Torngen.Client.Schema.ForumThreadResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:thread]

  defstruct [
    :thread
  ]

  @type t :: %__MODULE__{
          thread: Torngen.Client.Schema.ForumThreadExtended.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      thread: data |> Map.get("thread") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadExtended)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:thread, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumThreadExtended)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
