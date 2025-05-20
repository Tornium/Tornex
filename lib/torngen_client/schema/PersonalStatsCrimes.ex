defmodule Torngen.Client.Schema.PersonalStatsCrimes do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:crimes]

  defstruct [
    :crimes
  ]

  @type t :: %__MODULE__{
          crimes: Torngen.Client.Schema.PersonalStatsCrimesV2.t() | Torngen.Client.Schema.PersonalStatsCrimesV1.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crimes:
        Map.get(data, "crimes")
        |> Torngen.Client.Schema.parse(
          {:one_of, [Torngen.Client.Schema.PersonalStatsCrimesV2, Torngen.Client.Schema.PersonalStatsCrimesV1]}
        )
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

  defp validate_key?(:crimes, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [Torngen.Client.Schema.PersonalStatsCrimesV2, Torngen.Client.Schema.PersonalStatsCrimesV1]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
