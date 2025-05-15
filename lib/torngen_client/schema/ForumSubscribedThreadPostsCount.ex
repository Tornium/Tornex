defmodule Torngen.Client.Schema.ForumSubscribedThreadPostsCount do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :new
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          total: integer(),
          new: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: Map.get(data, "total"),
      new: Map.get(data, "new")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
