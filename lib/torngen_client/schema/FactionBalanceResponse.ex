defmodule Torngen.Client.Schema.FactionBalanceResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:balance]

  defstruct [
    :balance
  ]

  @type t :: %__MODULE__{
          balance: Torngen.Client.Schema.FactionBalance.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      balance: Map.get(data, "balance") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBalance)
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

  defp validate_key(:balance, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.FactionBalance)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
