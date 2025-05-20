defmodule Torngen.Client.Schema.TornItemWeaponDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stealth_level, :mods, :category, :base_stats, :ammo]

  defstruct [
    :stealth_level,
    :mods,
    :category,
    :base_stats,
    :ammo
  ]

  @type t :: %__MODULE__{
          stealth_level: integer() | float(),
          mods: [Torngen.Client.Schema.ItemModId.t()],
          category: Torngen.Client.Schema.TornItemWeaponCategoryEnum.t(),
          base_stats: Torngen.Client.Schema.TornItemBaseStats.t(),
          ammo:
            nil
            | %{
                :rate_of_fire => %{:minimum => integer(), :maximum => integer()},
                :name => String.t(),
                :magazine_rounds => integer(),
                :id => Torngen.Client.Schema.AmmoId.t()
              }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stealth_level: Map.get(data, "stealth_level") |> Torngen.Client.Schema.parse({:static, :number}),
      mods: Map.get(data, "mods") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ItemModId}),
      category:
        Map.get(data, "category") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemWeaponCategoryEnum),
      base_stats: Map.get(data, "base_stats") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemBaseStats),
      ammo:
        Map.get(data, "ammo")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             object: %{
               "id" => Torngen.Client.Schema.AmmoId,
               "magazine_rounds" => {:static, :integer},
               "name" => {:static, :string},
               "rate_of_fire" => {:object, %{"maximum" => {:static, :integer}, "minimum" => {:static, :integer}}}
             }
           ]}
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

  defp validate_key?(:stealth_level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:mods, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ItemModId})
  end

  defp validate_key?(:category, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornItemWeaponCategoryEnum)
  end

  defp validate_key?(:base_stats, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornItemBaseStats)
  end

  defp validate_key?(:ammo, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         static: :null,
         object: %{
           "id" => Torngen.Client.Schema.AmmoId,
           "magazine_rounds" => {:static, :integer},
           "name" => {:static, :string},
           "rate_of_fire" => {:object, %{"maximum" => {:static, :integer}, "minimum" => {:static, :integer}}}
         }
       ]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
