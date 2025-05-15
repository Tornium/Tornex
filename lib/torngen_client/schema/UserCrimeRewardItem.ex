defmodule Torngen.Client.Schema.UserCrimeRewardItem do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :id,
    :amount
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          id: integer(),
          amount: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      id: Map.get(data, "id"),
      amount: Map.get(data, "amount")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
