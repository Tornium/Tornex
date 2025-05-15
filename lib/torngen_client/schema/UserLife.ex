defmodule Torngen.Client.Schema.UserLife do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :maximum,
    :current
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          maximum: integer(),
          current: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      maximum: Map.get(data, "maximum"),
      current: Map.get(data, "current")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
