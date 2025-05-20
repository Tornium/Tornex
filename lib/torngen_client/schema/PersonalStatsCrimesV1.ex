defmodule Torngen.Client.Schema.PersonalStatsCrimesV1 do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

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
end
