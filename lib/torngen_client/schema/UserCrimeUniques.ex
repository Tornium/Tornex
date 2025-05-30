defmodule Torngen.Client.Schema.UserCrimeUniques do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rewards, :id]

  defstruct [
    :rewards,
    :id
  ]

  @type t :: %__MODULE__{
          rewards: Torngen.Client.Schema.UserCrimeUniquesReward.t(),
          id: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rewards: data |> Map.get("rewards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeUniquesReward),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:rewards, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserCrimeUniquesReward)
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
