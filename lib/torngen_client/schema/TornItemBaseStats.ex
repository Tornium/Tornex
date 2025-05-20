defmodule Torngen.Client.Schema.TornItemBaseStats do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:damage, :armor, :accuracy]

  defstruct [
    :damage,
    :armor,
    :accuracy
  ]

  @type t :: %__MODULE__{
          damage: integer(),
          armor: integer(),
          accuracy: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      damage: Map.get(data, "damage") |> Torngen.Client.Schema.parse({:static, :integer}),
      armor: Map.get(data, "armor") |> Torngen.Client.Schema.parse({:static, :integer}),
      accuracy: Map.get(data, "accuracy") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:damage, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:armor, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:accuracy, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
