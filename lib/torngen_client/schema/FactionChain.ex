defmodule Torngen.Client.Schema.FactionChain do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :start,
    :respect,
    :id,
    :end,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          start: integer(),
          respect: integer() | float(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          chain: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start: Map.get(data, "start"),
      respect: Map.get(data, "respect"),
      id: Map.get(data, "id"),
      end: Map.get(data, "end"),
      chain: Map.get(data, "chain")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
