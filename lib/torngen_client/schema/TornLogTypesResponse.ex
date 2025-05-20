defmodule Torngen.Client.Schema.TornLogTypesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:logtypes]

  defstruct [
    :logtypes
  ]

  @type t :: %__MODULE__{
          logtypes: [Torngen.Client.Schema.TornLog.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      logtypes: data |> Map.get("logtypes") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornLog})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:logtypes, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornLog})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
