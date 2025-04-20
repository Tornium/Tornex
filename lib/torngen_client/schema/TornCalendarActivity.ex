defmodule Torngen.Client.Schema.TornCalendarActivity do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :title,
    :start,
    :end,
    :description
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          start: integer(),
          end: integer(),
          description: String.t()
        }
end
