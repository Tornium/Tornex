defmodule Torngen.Client.Schema.FactionCrimeUser do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      progress: Map.get(data, "progress") |> Torngen.Client.Schema.parse({:static, :number}),
      outcome:
        Map.get(data, "outcome")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUserOutcome]}),
      joined_at: Map.get(data, "joined_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
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

  defp validate_key(:progress, value) do
    Torngen.Client.Schema.validate(value, {:static, :number})
  end

  defp validate_key(:outcome, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUserOutcome]})
  end

  defp validate_key(:joined_at, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
