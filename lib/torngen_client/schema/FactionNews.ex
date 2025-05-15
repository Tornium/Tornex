defmodule Torngen.Client.Schema.FactionNews do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :text,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          timestamp: integer(),
          text: String.t(),
          id: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp"),
      text: Map.get(data, "text"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
