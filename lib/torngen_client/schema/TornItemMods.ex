defmodule Torngen.Client.Schema.TornItemMods do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :weapons,
    :name,
    :id,
    :dual_fit,
    :description
  ]

  @type t :: %__MODULE__{
          weapons: [Torngen.Client.Schema.TornItemWeaponTypeEnum.t()],
          name: String.t(),
          id: Torngen.Client.Schema.ItemModId.t(),
          dual_fit: boolean(),
          description: String.t()
        }
end
