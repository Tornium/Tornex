defmodule Torngen.Client.Schema.PersonalStatsCrimesV1 do
  @moduledoc """
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
      version: Map.get(data, "version"),
      total: Map.get(data, "total"),
      theft: Map.get(data, "theft"),
      sell_illegal_goods: Map.get(data, "sell_illegal_goods"),
      other: Map.get(data, "other"),
      organized_crimes: Map.get(data, "organized_crimes"),
      murder: Map.get(data, "murder"),
      fraud: Map.get(data, "fraud"),
      drug_deals: Map.get(data, "drug_deals"),
      computer: Map.get(data, "computer"),
      auto_theft: Map.get(data, "auto_theft")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
