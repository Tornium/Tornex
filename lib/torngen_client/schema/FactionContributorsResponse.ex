defmodule Torngen.Client.Schema.FactionContributorsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:contributors]

  defstruct [
    :contributors
  ]

  @type t :: %__MODULE__{
          contributors: [Torngen.Client.Schema.FactionContributor.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      contributors:
        data
        |> Map.get("contributors")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionContributor})
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

  defp validate_key?(:contributors, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionContributor})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
