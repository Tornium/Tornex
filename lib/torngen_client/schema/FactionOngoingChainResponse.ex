defmodule Torngen.Client.Schema.FactionOngoingChainResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionOngoingChain)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
