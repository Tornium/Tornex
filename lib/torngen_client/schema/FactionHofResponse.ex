defmodule Torngen.Client.Schema.FactionHofResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:hof]

  defstruct [
    :hof
  ]

  @type t :: %__MODULE__{
          hof: Torngen.Client.Schema.FactionHofStats.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hof: data |> Map.get("hof") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionHofStats)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:hof, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionHofStats)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
