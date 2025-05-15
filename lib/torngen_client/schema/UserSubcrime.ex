defmodule Torngen.Client.Schema.UserSubcrime do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :success,
    :id,
    :fail
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          total: integer(),
          success: integer(),
          id: integer(),
          fail: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: Map.get(data, "total"),
      success: Map.get(data, "success"),
      id: Map.get(data, "id"),
      fail: Map.get(data, "fail")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
