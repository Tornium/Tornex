defmodule Torngen.Client.Schema.AttackSimplified do
  @moduledoc false

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
      started: data |> Map.get("started") |> Torngen.Client.Schema.parse({:static, :integer}),
      result: data |> Map.get("result") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionAttackResult),
      respect_loss: data |> Map.get("respect_loss") |> Torngen.Client.Schema.parse({:static, :number}),
      respect_gain: data |> Map.get("respect_gain") |> Torngen.Client.Schema.parse({:static, :number}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackId),
      ended: data |> Map.get("ended") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender:
        data |> Map.get("defender") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackPlayerSimplified),
      code: data |> Map.get("code") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackCode),
      attacker:
        data
        |> Map.get("attacker")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayerSimplified]})
    }
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
