defmodule Torngen.Client.Schema.TornItemAmmo do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :types,
    :price,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          types: [Torngen.Client.Schema.TornItemAmmoTypeEnum.t()],
          price: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.AmmoId.t()
        }
end
