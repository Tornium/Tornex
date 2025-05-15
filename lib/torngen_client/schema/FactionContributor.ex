defmodule Torngen.Client.Schema.FactionContributor do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :username,
    :in_faction,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          value: integer(),
          username: String.t(),
          in_faction: boolean(),
          id: Torngen.Client.Schema.UserId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value"),
      username: Map.get(data, "username"),
      in_faction: Map.get(data, "in_faction"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
