defmodule Torngen.Client.Schema.UserCrimeUniquesReward do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:money, :items, :ammo]

  defstruct [
    :money,
    :items,
    :ammo
  ]

  @type t :: %__MODULE__{
          money: nil | Torngen.Client.Schema.UserCrimeUniquesRewardMoney.t(),
          items: [Torngen.Client.Schema.UserCrimeRewardItem.t()],
          ammo: nil | Torngen.Client.Schema.UserCrimeUniquesRewardAmmo.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      money:
        data
        |> Map.get("money")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserCrimeUniquesRewardMoney]}),
      items:
        data |> Map.get("items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserCrimeRewardItem}),
      ammo:
        data
        |> Map.get("ammo")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserCrimeUniquesRewardAmmo]})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:money, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.UserCrimeUniquesRewardMoney]}
    )
  end

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserCrimeRewardItem})
  end

  defp validate_key?(:ammo, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.UserCrimeUniquesRewardAmmo]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
