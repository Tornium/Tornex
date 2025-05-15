defmodule Torngen.Client.Schema.FactionRank do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :wins,
    :position,
    :name,
    :level,
    :division
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          wins: integer(),
          position: integer(),
          name: String.t(),
          level: integer(),
          division: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      wins: Map.get(data, "wins"),
      position: Map.get(data, "position"),
      name: Map.get(data, "name"),
      level: Map.get(data, "level"),
      division: Map.get(data, "division")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
