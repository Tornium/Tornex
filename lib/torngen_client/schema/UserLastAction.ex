defmodule Torngen.Client.Schema.UserLastAction do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :status,
    :relative
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          timestamp: integer(),
          status: String.t(),
          relative: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp"),
      status: Map.get(data, "status"),
      relative: Map.get(data, "relative")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
