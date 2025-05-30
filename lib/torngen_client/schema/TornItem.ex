defmodule Torngen.Client.Schema.TornItem do
  @moduledoc false

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
        data
        |> Map.get("value")
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
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemTypeEnum),
      sub_type:
        data
        |> Map.get("sub_type")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.TornItemWeaponTypeEnum]}),
      requirement:
        data |> Map.get("requirement") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_tradable: data |> Map.get("is_tradable") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_masked: data |> Map.get("is_masked") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_found_in_city: data |> Map.get("is_found_in_city") |> Torngen.Client.Schema.parse({:static, :boolean}),
      image: data |> Map.get("image") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId),
      effect: data |> Map.get("effect") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      details:
        data
        |> Map.get("details")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [{:static, :null}, Torngen.Client.Schema.TornItemArmorDetails, Torngen.Client.Schema.TornItemWeaponDetails]}
        ),
      description: data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      circulation: data |> Map.get("circulation") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(
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

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornItemTypeEnum)
  end

  defp validate_key?(:sub_type, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.TornItemWeaponTypeEnum]})
  end

  defp validate_key?(:requirement, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:is_tradable, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_masked, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_found_in_city, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:image, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemId)
  end

  defp validate_key?(:effect, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:details, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [{:static, :null}, Torngen.Client.Schema.TornItemArmorDetails, Torngen.Client.Schema.TornItemWeaponDetails]}
    )
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:circulation, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
