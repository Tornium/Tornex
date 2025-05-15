defmodule Torngen.Client.Schema.FactionPositionsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :positions
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          positions: [Torngen.Client.Schema.FactionPosition.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      positions: Map.get(data, "positions")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
