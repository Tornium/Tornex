defmodule Torngen.Client.Schema.FactionTerritoryWarReportFaction do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :name,
    :members,
    :joins,
    :is_aggressor,
    :id,
    :clears
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          score: integer(),
          name: String.t(),
          members: [Torngen.Client.Schema.FactionTerritoryWarReportMembers.t()],
          joins: integer(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          clears: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: Map.get(data, "score"),
      name: Map.get(data, "name"),
      members: Map.get(data, "members"),
      joins: Map.get(data, "joins"),
      is_aggressor: Map.get(data, "is_aggressor"),
      id: Map.get(data, "id"),
      clears: Map.get(data, "clears")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
