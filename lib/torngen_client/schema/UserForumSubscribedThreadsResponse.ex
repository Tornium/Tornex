defmodule Torngen.Client.Schema.UserForumSubscribedThreadsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumSubscribedThreads
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          forumSubscribedThreads: [Torngen.Client.Schema.ForumSubscribedThread.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      forumSubscribedThreads: Map.get(data, "forumSubscribedThreads")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
