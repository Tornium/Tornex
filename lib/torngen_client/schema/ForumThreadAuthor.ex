defmodule Torngen.Client.Schema.ForumThreadAuthor do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :username,
    :karma,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          username: String.t(),
          karma: integer(),
          id: Torngen.Client.Schema.UserId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      username: Map.get(data, "username"),
      karma: Map.get(data, "karma"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
