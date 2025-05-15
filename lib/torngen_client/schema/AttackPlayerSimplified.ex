defmodule Torngen.Client.Schema.AttackPlayerSimplified do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :id,
    :faction_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      id: Map.get(data, "id"),
      faction_id: Map.get(data, "faction_id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
