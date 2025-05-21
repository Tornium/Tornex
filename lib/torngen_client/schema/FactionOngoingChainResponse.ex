defmodule Torngen.Client.Schema.FactionOngoingChainResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:chain]

  defstruct [
    :chain
  ]

  @type t :: %__MODULE__{
          chain: Torngen.Client.Schema.FactionOngoingChain.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      chain: data |> Map.get("chain") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionOngoingChain)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionOngoingChain)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
