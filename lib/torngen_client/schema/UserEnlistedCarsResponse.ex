defmodule Torngen.Client.Schema.UserEnlistedCarsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:enlistedcars]

  defstruct [
    :enlistedcars
  ]

  @type t :: %__MODULE__{
          enlistedcars: [Torngen.Client.Schema.UserRaceCarDetails.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      enlistedcars:
        data
        |> Map.get("enlistedcars")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserRaceCarDetails})
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

  defp validate_key?(:enlistedcars, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserRaceCarDetails})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
