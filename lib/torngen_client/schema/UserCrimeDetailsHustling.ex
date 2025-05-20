defmodule Torngen.Client.Schema.UserCrimeDetailsHustling do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
        Map.get(data, "total_audience_gathered") |> Torngen.Client.Schema.parse({:static, :integer}),
      shill_money_collected: Map.get(data, "shill_money_collected") |> Torngen.Client.Schema.parse({:static, :integer}),
      pickpocket_money_collected:
        Map.get(data, "pickpocket_money_collected") |> Torngen.Client.Schema.parse({:static, :integer}),
      biggest_money_won: Map.get(data, "biggest_money_won") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:total_audience_gathered, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:shill_money_collected, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:pickpocket_money_collected, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:biggest_money_won, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
