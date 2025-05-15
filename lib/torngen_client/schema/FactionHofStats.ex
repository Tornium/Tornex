defmodule Torngen.Client.Schema.FactionHofStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :rank,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          respect: Torngen.Client.Schema.HofValue.t(),
          rank: Torngen.Client.Schema.HofValueString.t(),
          chain: Torngen.Client.Schema.HofValue.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect: Map.get(data, "respect"),
      rank: Map.get(data, "rank"),
      chain: Map.get(data, "chain")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
