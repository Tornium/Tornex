defmodule Torngen.Client.Schema.ForumThreadResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :thread
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          thread: Torngen.Client.Schema.ForumThreadExtended.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      thread: Map.get(data, "thread")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
