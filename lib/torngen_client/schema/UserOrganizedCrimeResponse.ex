defmodule Torngen.Client.Schema.UserOrganizedCrimeResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:organizedCrime]

  defstruct [
    :organizedCrime
  ]

  @type t :: %__MODULE__{
          organizedCrime: nil | Torngen.Client.Schema.FactionCrime.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      organizedCrime:
        data
        |> Map.get("organizedCrime")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrime]})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:organizedCrime, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrime]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
