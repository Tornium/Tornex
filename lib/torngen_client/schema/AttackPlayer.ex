defmodule Torngen.Client.Schema.AttackPlayer do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :level,
    :id,
    :faction
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          faction: nil | Torngen.Client.Schema.AttackPlayerFaction.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name"),
      level: Map.get(data, "level"),
      id: Map.get(data, "id"),
      faction: Map.get(data, "faction")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
