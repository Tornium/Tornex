defmodule Torngen.Client.Schema.RaceCarUpgrade do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      subcategory:
        Map.get(data, "subcategory") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceCarUpgradeSubCategory),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceCarUpgradeId),
      effects:
        Map.get(data, "effects")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "acceleration" => {:static, :integer},
             "braking" => {:static, :integer},
             "dirt" => {:static, :integer},
             "handling" => {:static, :integer},
             "safety" => {:static, :integer},
             "tarmac" => {:static, :integer},
             "top_speed" => {:static, :integer}
           }}
        ),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string}),
      cost:
        Map.get(data, "cost")
        |> Torngen.Client.Schema.parse({:object, %{"cash" => {:static, :integer}, "points" => {:static, :integer}}}),
      class_required:
        Map.get(data, "class_required") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceClassEnum),
      category: Map.get(data, "category") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceCarUpgradeCategory)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
