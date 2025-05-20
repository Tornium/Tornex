defmodule Torngen.Client.Schema.TornItemAmmo do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      types:
        Map.get(data, "types") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemAmmoTypeEnum}),
      price: Map.get(data, "price") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AmmoId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
