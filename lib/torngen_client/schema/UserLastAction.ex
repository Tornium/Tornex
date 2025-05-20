defmodule Torngen.Client.Schema.UserLastAction do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :status, :relative]

  defstruct [
    :timestamp,
    :status,
    :relative
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          status: String.t(),
          relative: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      status: Map.get(data, "status") |> Torngen.Client.Schema.parse({:static, :string}),
      relative: Map.get(data, "relative") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:relative, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
