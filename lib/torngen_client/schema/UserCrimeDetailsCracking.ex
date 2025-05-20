defmodule Torngen.Client.Schema.UserCrimeDetailsCracking do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:highest_mips, :encryption_layers_broken, :chars_guessed_total, :chars_guessed, :brute_force_cycles]

  defstruct [
    :highest_mips,
    :encryption_layers_broken,
    :chars_guessed_total,
    :chars_guessed,
    :brute_force_cycles
  ]

  @type t :: %__MODULE__{
          highest_mips: integer(),
          encryption_layers_broken: integer(),
          chars_guessed_total: integer(),
          chars_guessed: integer(),
          brute_force_cycles: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      highest_mips: Map.get(data, "highest_mips") |> Torngen.Client.Schema.parse({:static, :integer}),
      encryption_layers_broken:
        Map.get(data, "encryption_layers_broken") |> Torngen.Client.Schema.parse({:static, :integer}),
      chars_guessed_total: Map.get(data, "chars_guessed_total") |> Torngen.Client.Schema.parse({:static, :integer}),
      chars_guessed: Map.get(data, "chars_guessed") |> Torngen.Client.Schema.parse({:static, :integer}),
      brute_force_cycles: Map.get(data, "brute_force_cycles") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:highest_mips, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:encryption_layers_broken, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:chars_guessed_total, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:chars_guessed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:brute_force_cycles, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
