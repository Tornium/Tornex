defmodule Torngen.Client.Schema.RaceCarUpgrade do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:subcategory, :name, :id, :effects, :description, :cost, :class_required, :category]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      subcategory:
        data |> Map.get("subcategory") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceCarUpgradeSubCategory),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceCarUpgradeId),
      effects:
        data
        |> Map.get("effects")
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
      description: data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      cost:
        data
        |> Map.get("cost")
        |> Torngen.Client.Schema.parse({:object, %{"cash" => {:static, :integer}, "points" => {:static, :integer}}}),
      class_required:
        data |> Map.get("class_required") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceClassEnum),
      category: data |> Map.get("category") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceCarUpgradeCategory)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:subcategory, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceCarUpgradeSubCategory)
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceCarUpgradeId)
  end

  defp validate_key?(:effects, value) do
    Torngen.Client.Schema.validate?(
      value,
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
    )
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:object, %{"cash" => {:static, :integer}, "points" => {:static, :integer}}})
  end

  defp validate_key?(:class_required, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceClassEnum)
  end

  defp validate_key?(:category, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceCarUpgradeCategory)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
