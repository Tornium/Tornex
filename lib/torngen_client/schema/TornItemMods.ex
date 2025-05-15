defmodule Torngen.Client.Schema.TornItemMods do
  @moduledoc """
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
      weapons: Map.get(data, "weapons"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      dual_fit: Map.get(data, "dual_fit"),
      description: Map.get(data, "description")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
