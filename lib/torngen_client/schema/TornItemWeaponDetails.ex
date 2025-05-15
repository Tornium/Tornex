defmodule Torngen.Client.Schema.TornItemWeaponDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :stealth_level,
    :mods,
    :category,
    :base_stats,
    :ammo
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stealth_level: Map.get(data, "stealth_level"),
      mods: Map.get(data, "mods"),
      category: Map.get(data, "category"),
      base_stats: Map.get(data, "base_stats"),
      ammo: Map.get(data, "ammo")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
