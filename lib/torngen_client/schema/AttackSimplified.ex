defmodule Torngen.Client.Schema.AttackSimplified do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:started, :result, :respect_loss, :respect_gain, :id, :ended, :defender, :code, :attacker]

  defstruct [
    :started,
    :result,
    :respect_loss,
    :respect_gain,
    :id,
    :ended,
    :defender,
    :code,
    :attacker
  ]

  @type t :: %__MODULE__{
          started: integer(),
          result: Torngen.Client.Schema.FactionAttackResult.t(),
          respect_loss: integer() | float(),
          respect_gain: integer() | float(),
          id: Torngen.Client.Schema.AttackId.t(),
          ended: integer(),
          defender: Torngen.Client.Schema.AttackPlayerSimplified.t(),
          code: Torngen.Client.Schema.AttackCode.t(),
          attacker: nil | Torngen.Client.Schema.AttackPlayerSimplified.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      started: Map.get(data, "started") |> Torngen.Client.Schema.parse({:static, :integer}),
      result: Map.get(data, "result") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionAttackResult),
      respect_loss: Map.get(data, "respect_loss") |> Torngen.Client.Schema.parse({:static, :number}),
      respect_gain: Map.get(data, "respect_gain") |> Torngen.Client.Schema.parse({:static, :number}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackId),
      ended: Map.get(data, "ended") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender: Map.get(data, "defender") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackPlayerSimplified),
      code: Map.get(data, "code") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackCode),
      attacker:
        Map.get(data, "attacker")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayerSimplified]})
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:started, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:result, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionAttackResult)
  end

  defp validate_key?(:respect_loss, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:respect_gain, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackId)
  end

  defp validate_key?(:ended, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:defender, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackPlayerSimplified)
  end

  defp validate_key?(:code, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackCode)
  end

  defp validate_key?(:attacker, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayerSimplified]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
