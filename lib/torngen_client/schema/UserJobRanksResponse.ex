defmodule Torngen.Client.Schema.UserJobRanksResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:jobranks]

  defstruct [
    :jobranks
  ]

  @type t :: %__MODULE__{
          jobranks: Torngen.Client.Schema.UserJobRanks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jobranks: data |> Map.get("jobranks") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserJobRanks)
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

  defp validate_key?(:jobranks, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserJobRanks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
