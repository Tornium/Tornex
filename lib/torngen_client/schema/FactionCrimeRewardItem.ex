defmodule Torngen.Client.Schema.FactionCrimeRewardItem do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :quantity,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          quantity: integer(),
          id: Torngen.Client.Schema.ItemId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      quantity: Map.get(data, "quantity"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
