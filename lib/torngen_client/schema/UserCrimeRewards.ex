defmodule Torngen.Client.Schema.UserCrimeRewards do
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
          money: integer(),
          items: [Torngen.Client.Schema.UserCrimeRewardItem.t()],
          ammo: Torngen.Client.Schema.UserCrimeRewardAmmo.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      money: Map.get(data, "money") |> Torngen.Client.Schema.parse({:static, :integer}),
      items: Map.get(data, "items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserCrimeRewardItem}),
      ammo: Map.get(data, "ammo") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeRewardAmmo)
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:money, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserCrimeRewardItem})
  end

  defp validate_key?(:ammo, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserCrimeRewardAmmo)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
