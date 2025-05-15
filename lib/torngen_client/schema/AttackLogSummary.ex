defmodule Torngen.Client.Schema.AttackLogSummary do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :misses,
    :id,
    :hits,
    :damage
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          name: nil | String.t(),
          misses: integer(),
          id: nil | Torngen.Client.Schema.UserId.t(),
          hits: integer(),
          damage: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name"),
      misses: Map.get(data, "misses"),
      id: Map.get(data, "id"),
      hits: Map.get(data, "hits"),
      damage: Map.get(data, "damage")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
