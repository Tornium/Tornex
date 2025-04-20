defmodule Torngen.Client.Schema.RaceCarUpgrade do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :subcategory,
    :name,
    :id,
    :effects,
    :description,
    :cost,
    :class_required,
    :category
  ]

  @type t :: %__MODULE__{
          subcategory: Torngen.Client.Schema.RaceCarUpgradeSubCategory.t(),
          name: String.t(),
          id: Torngen.Client.Schema.RaceCarUpgradeId.t(),
          effects: %{
            :top_speed => integer(),
            :tarmac => integer(),
            :safety => integer(),
            :handling => integer(),
            :dirt => integer(),
            :braking => integer(),
            :acceleration => integer()
          },
          description: String.t(),
          cost: %{:points => integer(), :cash => integer()},
          class_required: Torngen.Client.Schema.RaceClassEnum.t(),
          category: Torngen.Client.Schema.RaceCarUpgradeCategory.t()
        }
end
