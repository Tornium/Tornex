defmodule Torngen.Client.Schema.FactionCrime do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :status,
    :slots,
    :rewards,
    :ready_at,
    :previous_crime_id,
    :planning_at,
    :name,
    :id,
    :expired_at,
    :executed_at,
    :difficulty,
    :created_at
  ]

  defstruct [
    :status,
    :slots,
    :rewards,
    :ready_at,
    :previous_crime_id,
    :planning_at,
    :name,
    :id,
    :expired_at,
    :executed_at,
    :difficulty,
    :created_at
  ]

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.FactionCrimeStatusEnum.t(),
          slots: [Torngen.Client.Schema.FactionCrimeSlot.t()],
          rewards: nil | Torngen.Client.Schema.FactionCrimeReward.t(),
          ready_at: nil | integer(),
          previous_crime_id: nil | Torngen.Client.Schema.FactionCrimeId.t(),
          planning_at: nil | integer(),
          name: String.t(),
          id: Torngen.Client.Schema.FactionCrimeId.t(),
          expired_at: integer(),
          executed_at: nil | integer(),
          difficulty: integer(),
          created_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status: Map.get(data, "status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionCrimeStatusEnum),
      slots: Map.get(data, "slots") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionCrimeSlot}),
      rewards:
        Map.get(data, "rewards")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeReward]}),
      ready_at: Map.get(data, "ready_at") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      previous_crime_id:
        Map.get(data, "previous_crime_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeId]}),
      planning_at:
        Map.get(data, "planning_at") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionCrimeId),
      expired_at: Map.get(data, "expired_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      executed_at:
        Map.get(data, "executed_at") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      difficulty: Map.get(data, "difficulty") |> Torngen.Client.Schema.parse({:static, :integer}),
      created_at: Map.get(data, "created_at") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionCrimeStatusEnum)
  end

  defp validate_key?(:slots, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionCrimeSlot})
  end

  defp validate_key?(:rewards, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeReward]})
  end

  defp validate_key?(:ready_at, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:previous_crime_id, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeId]})
  end

  defp validate_key?(:planning_at, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionCrimeId)
  end

  defp validate_key?(:expired_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:executed_at, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:difficulty, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:created_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
