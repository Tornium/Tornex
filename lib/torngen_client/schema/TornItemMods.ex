defmodule Torngen.Client.Schema.TornItemMods do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :weapons,
    :name,
    :id,
    :dual_fit,
    :description
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          weapons: [Torngen.Client.Schema.TornItemWeaponTypeEnum.t()],
          name: String.t(),
          id: Torngen.Client.Schema.ItemModId.t(),
          dual_fit: boolean(),
          description: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      weapons:
        Map.get(data, "weapons") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemWeaponTypeEnum}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemModId),
      dual_fit: Map.get(data, "dual_fit") |> Torngen.Client.Schema.parse({:static, :boolean}),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
