defmodule Torngen.Client.Schema.UserCrimeDetailsHustling do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:total_audience_gathered, :shill_money_collected, :pickpocket_money_collected, :biggest_money_won]

  defstruct [
    :total_audience_gathered,
    :shill_money_collected,
    :pickpocket_money_collected,
    :biggest_money_won
  ]

  @type t :: %__MODULE__{
          total_audience_gathered: integer(),
          shill_money_collected: integer(),
          pickpocket_money_collected: integer(),
          biggest_money_won: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total_audience_gathered:
        data |> Map.get("total_audience_gathered") |> Torngen.Client.Schema.parse({:static, :integer}),
      shill_money_collected:
        data |> Map.get("shill_money_collected") |> Torngen.Client.Schema.parse({:static, :integer}),
      pickpocket_money_collected:
        data |> Map.get("pickpocket_money_collected") |> Torngen.Client.Schema.parse({:static, :integer}),
      biggest_money_won: data |> Map.get("biggest_money_won") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:total_audience_gathered, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:shill_money_collected, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:pickpocket_money_collected, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:biggest_money_won, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
