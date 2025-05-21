defmodule Torngen.Client.Schema.FactionTerritoryWarParticipant do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:score, :playerIds, :name, :is_aggressor, :id, :chain]

  defstruct [
    :score,
    :playerIds,
    :name,
    :is_aggressor,
    :id,
    :chain
  ]

  @type t :: %__MODULE__{
          score: integer(),
          playerIds: [Torngen.Client.Schema.UserId.t()],
          name: String.t(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: data |> Map.get("score") |> Torngen.Client.Schema.parse({:static, :integer}),
      playerIds: data |> Map.get("playerIds") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserId}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_aggressor: data |> Map.get("is_aggressor") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      chain: data |> Map.get("chain") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:score, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:playerIds, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:is_aggressor, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
