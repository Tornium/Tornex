defmodule Torngen.Client.Schema.FactionTerritoryOwnership do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :owned_by,
    :id,
    :acquired_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          owned_by: nil | Torngen.Client.Schema.FactionId.t(),
          id: String.t(),
          acquired_at: nil | integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      owned_by: Map.get(data, "owned_by"),
      id: Map.get(data, "id"),
      acquired_at: Map.get(data, "acquired_at")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
