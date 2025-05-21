defmodule Torngen.Client.Schema.FactionCrimeUser do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:progress, :outcome, :joined_at, :id]

  defstruct [
    :progress,
    :outcome,
    :joined_at,
    :id
  ]

  @type t :: %__MODULE__{
          progress: integer() | float(),
          outcome: nil | Torngen.Client.Schema.FactionCrimeUserOutcome.t(),
          joined_at: integer(),
          id: Torngen.Client.Schema.UserId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      progress: data |> Map.get("progress") |> Torngen.Client.Schema.parse({:static, :number}),
      outcome:
        data
        |> Map.get("outcome")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUserOutcome]}),
      joined_at: data |> Map.get("joined_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:progress, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:outcome, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUserOutcome]})
  end

  defp validate_key?(:joined_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
