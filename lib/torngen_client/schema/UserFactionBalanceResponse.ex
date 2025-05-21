defmodule Torngen.Client.Schema.UserFactionBalanceResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:factionBalance]

  defstruct [
    :factionBalance
  ]

  @type t :: %__MODULE__{
          factionBalance: nil | Torngen.Client.Schema.UserFactionBalance.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      factionBalance:
        data
        |> Map.get("factionBalance")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserFactionBalance]})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:factionBalance, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.UserFactionBalance]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
