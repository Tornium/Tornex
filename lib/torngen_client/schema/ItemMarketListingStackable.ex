defmodule Torngen.Client.Schema.ItemMarketListingStackable do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:price, :amount]

  defstruct [
    :price,
    :amount
  ]

  @type t :: %__MODULE__{
          price: integer(),
          amount: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer}),
      amount: data |> Map.get("amount") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:amount, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
