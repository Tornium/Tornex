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
end
