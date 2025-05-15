defmodule Torngen.Client.Schema.FactionTerritoryWarReportMembers do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :username,
    :score,
    :level,
    :joins,
    :id,
    :clears
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          username: String.t(),
          score: integer(),
          level: integer(),
          joins: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          clears: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      username: Map.get(data, "username"),
      score: Map.get(data, "score"),
      level: Map.get(data, "level"),
      joins: Map.get(data, "joins"),
      id: Map.get(data, "id"),
      clears: Map.get(data, "clears")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
