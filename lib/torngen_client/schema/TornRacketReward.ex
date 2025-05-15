defmodule Torngen.Client.Schema.TornRacketReward do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :type,
    :quantity,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.TornRacketType.t(),
          quantity: integer(),
          id: nil | Torngen.Client.Schema.ItemId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type"),
      quantity: Map.get(data, "quantity"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
