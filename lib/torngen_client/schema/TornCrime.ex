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

  @type t :: %__MODULE__{
          unique_outcomes_ids: [integer()],
          unique_outcomes_count: integer(),
          notes: [String.t()],
          name: String.t(),
          id: integer(),
          enhancer_name: String.t(),
          enhancer_id: integer(),
          category_name: String.t(),
          category_id: integer()
        }
end
