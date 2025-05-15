defmodule Torngen.Client.Schema.FactionOngoingChainResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          chain: Torngen.Client.Schema.FactionOngoingChain.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      chain: Map.get(data, "chain")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
