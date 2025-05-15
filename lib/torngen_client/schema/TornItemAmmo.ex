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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          types: [Torngen.Client.Schema.TornItemAmmoTypeEnum.t()],
          price: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.AmmoId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      types: Map.get(data, "types"),
      price: Map.get(data, "price"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
