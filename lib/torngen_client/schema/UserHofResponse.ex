defmodule Torngen.Client.Schema.UserHofResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:hof]

  defstruct [
    :hof
  ]

  @type t :: %__MODULE__{
          hof: Torngen.Client.Schema.UserHofStats.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hof: Map.get(data, "hof") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserHofStats)
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:hof, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserHofStats)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
