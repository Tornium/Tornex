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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          title: String.t(),
          start: integer(),
          end: integer(),
          description: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: Map.get(data, "title"),
      start: Map.get(data, "start"),
      end: Map.get(data, "end"),
      description: Map.get(data, "description")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
