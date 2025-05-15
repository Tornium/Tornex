defmodule Torngen.Client.Schema.TornCrime do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :unique_outcomes_ids,
    :unique_outcomes_count,
    :notes,
    :name,
    :id,
    :enhancer_name,
    :enhancer_id,
    :category_name,
    :category_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          unique_outcomes_ids: [integer()],
          unique_outcomes_count: integer(),
          notes: [String.t()],
          name: String.t(),
          id: Torngen.Client.Schema.TornCrimeId.t(),
          enhancer_name: String.t(),
          enhancer_id: integer(),
          category_name: String.t(),
          category_id: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      unique_outcomes_ids: Map.get(data, "unique_outcomes_ids"),
      unique_outcomes_count: Map.get(data, "unique_outcomes_count"),
      notes: Map.get(data, "notes"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      enhancer_name: Map.get(data, "enhancer_name"),
      enhancer_id: Map.get(data, "enhancer_id"),
      category_name: Map.get(data, "category_name"),
      category_id: Map.get(data, "category_id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
