defmodule Torngen.Client.Schema.TornSubcrime do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :nerve_cost,
    :name,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          nerve_cost: integer(),
          name: String.t(),
          id: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      nerve_cost: Map.get(data, "nerve_cost"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
