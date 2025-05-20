defmodule Torngen.Client.Schema.PersonalStatsCrimesV1 do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :version,
    :total,
    :theft,
    :sell_illegal_goods,
    :other,
    :organized_crimes,
    :murder,
    :fraud,
    :drug_deals,
    :computer,
    :auto_theft
  ]

  defstruct [
    :version,
    :total,
    :theft,
    :sell_illegal_goods,
    :other,
    :organized_crimes,
    :murder,
    :fraud,
    :drug_deals,
    :computer,
    :auto_theft
  ]

  @type t :: %__MODULE__{
          version: String.t(),
          total: integer(),
          theft: integer(),
          sell_illegal_goods: integer(),
          other: integer(),
          organized_crimes: integer(),
          murder: integer(),
          fraud: integer(),
          drug_deals: integer(),
          computer: integer(),
          auto_theft: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      version: Map.get(data, "version") |> Torngen.Client.Schema.parse({:static, :string}),
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      theft: Map.get(data, "theft") |> Torngen.Client.Schema.parse({:static, :integer}),
      sell_illegal_goods: Map.get(data, "sell_illegal_goods") |> Torngen.Client.Schema.parse({:static, :integer}),
      other: Map.get(data, "other") |> Torngen.Client.Schema.parse({:static, :integer}),
      organized_crimes: Map.get(data, "organized_crimes") |> Torngen.Client.Schema.parse({:static, :integer}),
      murder: Map.get(data, "murder") |> Torngen.Client.Schema.parse({:static, :integer}),
      fraud: Map.get(data, "fraud") |> Torngen.Client.Schema.parse({:static, :integer}),
      drug_deals: Map.get(data, "drug_deals") |> Torngen.Client.Schema.parse({:static, :integer}),
      computer: Map.get(data, "computer") |> Torngen.Client.Schema.parse({:static, :integer}),
      auto_theft: Map.get(data, "auto_theft") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:version, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:total, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:theft, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:sell_illegal_goods, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:other, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:organized_crimes, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:murder, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:fraud, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:drug_deals, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:computer, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:auto_theft, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
