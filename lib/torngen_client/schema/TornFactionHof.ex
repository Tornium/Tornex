defmodule Torngen.Client.Schema.TornFactionHof do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :values,
    :rank,
    :position,
    :name,
    :members,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          values: Torngen.Client.Schema.FactionHofValues.t(),
          rank: String.t(),
          position: integer(),
          name: String.t(),
          members: integer(),
          id: Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: Map.get(data, "values"),
      rank: Map.get(data, "rank"),
      position: Map.get(data, "position"),
      name: Map.get(data, "name"),
      members: Map.get(data, "members"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
