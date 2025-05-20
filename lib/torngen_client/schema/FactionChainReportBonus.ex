defmodule Torngen.Client.Schema.FactionChainReportBonus do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:respect, :defender_id, :chain, :attacker_id]

  defstruct [
    :respect,
    :defender_id,
    :chain,
    :attacker_id
  ]

  @type t :: %__MODULE__{
          respect: integer(),
          defender_id: Torngen.Client.Schema.UserId.t(),
          chain: integer(),
          attacker_id: Torngen.Client.Schema.UserId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender_id: Map.get(data, "defender_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse({:static, :integer}),
      attacker_id: Map.get(data, "attacker_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
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

  defp validate_key(:respect, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:defender_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:chain, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:attacker_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
