defmodule Torngen.Client.Schema.FactionUpgradeDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :unlocked_at,
    :name,
    :level,
    :id,
    :cost,
    :ability
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          unlocked_at: integer(),
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.FactionBranchId.t(),
          cost: integer(),
          ability: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      unlocked_at: Map.get(data, "unlocked_at"),
      name: Map.get(data, "name"),
      level: Map.get(data, "level"),
      id: Map.get(data, "id"),
      cost: Map.get(data, "cost"),
      ability: Map.get(data, "ability")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
