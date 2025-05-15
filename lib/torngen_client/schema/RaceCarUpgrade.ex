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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      subcategory: Map.get(data, "subcategory"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      effects: Map.get(data, "effects"),
      description: Map.get(data, "description"),
      cost: Map.get(data, "cost"),
      class_required: Map.get(data, "class_required"),
      category: Map.get(data, "category")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
