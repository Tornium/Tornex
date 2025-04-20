defmodule Torngen.Client.Schema.TornSubcrime do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :nerve_cost,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          nerve_cost: integer(),
          name: String.t(),
          id: integer()
        }
end
