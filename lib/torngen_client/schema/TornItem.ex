defmodule Torngen.Client.Schema.TornItem do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :value,
    :type,
    :sub_type,
    :requirement,
    :name,
    :is_tradable,
    :is_masked,
    :is_found_in_city,
    :image,
    :id,
    :effect,
    :details,
    :description,
    :circulation
  ]

  defstruct [
    :value,
    :type,
    :sub_type,
    :requirement,
    :name,
    :is_tradable,
    :is_masked,
    :is_found_in_city,
    :image,
    :id,
    :effect,
    :details,
    :description,
    :circulation
  ]

  @type t :: %__MODULE__{
          value: %{
            :vendor => nil | %{:name => String.t(), :country => String.t()},
            :sell_price => nil | integer(),
            :market_price => integer(),
            :buy_price => nil | integer()
          },
          type: Torngen.Client.Schema.TornItemTypeEnum.t(),
          sub_type: nil | Torngen.Client.Schema.TornItemWeaponTypeEnum.t(),
          requirement: nil | String.t(),
          name: String.t(),
          is_tradable: boolean(),
          is_masked: boolean(),
          is_found_in_city: boolean(),
          image: String.t(),
          id: Torngen.Client.Schema.ItemId.t(),
          effect: nil | String.t(),
          details:
            nil | Torngen.Client.Schema.TornItemArmorDetails.t() | Torngen.Client.Schema.TornItemWeaponDetails.t(),
          description: String.t(),
          circulation: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value:
        Map.get(data, "value")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "buy_price" => {:one_of, [static: :null, static: :integer]},
             "market_price" => {:static, :integer},
             "sell_price" => {:one_of, [static: :null, static: :integer]},
             "vendor" =>
               {:one_of, [static: :null, object: %{"country" => {:static, :string}, "name" => {:static, :string}}]}
           }}
        ),
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemTypeEnum),
      sub_type:
        Map.get(data, "sub_type")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.TornItemWeaponTypeEnum]}),
      requirement:
        Map.get(data, "requirement") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_tradable: Map.get(data, "is_tradable") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_masked: Map.get(data, "is_masked") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_found_in_city: Map.get(data, "is_found_in_city") |> Torngen.Client.Schema.parse({:static, :boolean}),
      image: Map.get(data, "image") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId),
      effect: Map.get(data, "effect") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      details:
        Map.get(data, "details")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [{:static, :null}, Torngen.Client.Schema.TornItemArmorDetails, Torngen.Client.Schema.TornItemWeaponDetails]}
        ),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string}),
      circulation: Map.get(data, "circulation") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:value, value) do
    Torngen.Client.Schema.validate(
      value,
      {:object,
       %{
         "buy_price" => {:one_of, [static: :null, static: :integer]},
         "market_price" => {:static, :integer},
         "sell_price" => {:one_of, [static: :null, static: :integer]},
         "vendor" =>
           {:one_of, [static: :null, object: %{"country" => {:static, :string}, "name" => {:static, :string}}]}
       }}
    )
  end

  defp validate_key(:type, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.TornItemTypeEnum)
  end

  defp validate_key(:sub_type, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.TornItemWeaponTypeEnum]})
  end

  defp validate_key(:requirement, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key(:name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:is_tradable, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:is_masked, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:is_found_in_city, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:image, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ItemId)
  end

  defp validate_key(:effect, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key(:details, value) do
    Torngen.Client.Schema.validate(
      value,
      {:one_of,
       [{:static, :null}, Torngen.Client.Schema.TornItemArmorDetails, Torngen.Client.Schema.TornItemWeaponDetails]}
    )
  end

  defp validate_key(:description, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:circulation, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
