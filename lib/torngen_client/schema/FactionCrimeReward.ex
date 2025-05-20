defmodule Torngen.Client.Schema.FactionCrimeReward do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:scope, :respect, :payout, :money, :items]

  defstruct [
    :scope,
    :respect,
    :payout,
    :money,
    :items
  ]

  @type t :: %__MODULE__{
          scope: integer(),
          respect: integer(),
          payout: nil | Torngen.Client.Schema.FactionCrimeRewardPayout.t(),
          money: integer(),
          items: [Torngen.Client.Schema.FactionCrimeRewardItem.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      scope: data |> Map.get("scope") |> Torngen.Client.Schema.parse({:static, :integer}),
      respect: data |> Map.get("respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      payout:
        data
        |> Map.get("payout")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeRewardPayout]}),
      money: data |> Map.get("money") |> Torngen.Client.Schema.parse({:static, :integer}),
      items:
        data |> Map.get("items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionCrimeRewardItem})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:scope, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:payout, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeRewardPayout]}
    )
  end

  defp validate_key?(:money, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionCrimeRewardItem})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
