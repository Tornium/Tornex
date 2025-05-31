defmodule Torngen.Client.Schema.UserCrimesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:crimes]

  defstruct [
    :crimes
  ]

  @type t :: %__MODULE__{
          crimes: Torngen.Client.Schema.UserCrime.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crimes: data |> Map.get("crimes") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrime)
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

  defp validate_key?(:crimes, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserCrime)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
