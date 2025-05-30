defmodule Torngen.Client.Schema.PersonalStatsBattleStats do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:battle_stats]

  defstruct [
    :battle_stats
  ]

  @type t :: %__MODULE__{
          battle_stats: %{
            :total => integer(),
            :strength => integer(),
            :speed => integer(),
            :dexterity => integer(),
            :defense => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      battle_stats:
        data
        |> Map.get("battle_stats")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "defense" => {:static, :integer},
             "dexterity" => {:static, :integer},
             "speed" => {:static, :integer},
             "strength" => {:static, :integer},
             "total" => {:static, :integer}
           }}
        )
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

  defp validate_key?(:battle_stats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "defense" => {:static, :integer},
         "dexterity" => {:static, :integer},
         "speed" => {:static, :integer},
         "strength" => {:static, :integer},
         "total" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
