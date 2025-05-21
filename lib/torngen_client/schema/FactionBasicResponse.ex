defmodule Torngen.Client.Schema.FactionBasicResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:basic]

  defstruct [
    :basic
  ]

  @type t :: %__MODULE__{
          basic: Torngen.Client.Schema.FactionBasic.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      basic: data |> Map.get("basic") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBasic)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:basic, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionBasic)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
