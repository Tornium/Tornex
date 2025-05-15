defmodule Torngen.Client.Schema.FactionRankedWarParticipant do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :name,
    :id,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          score: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: Map.get(data, "score"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      chain: Map.get(data, "chain")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
