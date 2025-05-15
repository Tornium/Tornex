defmodule Torngen.Client.Schema.AttackPlayerFaction do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
