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
end
