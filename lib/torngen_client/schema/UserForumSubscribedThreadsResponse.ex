defmodule Torngen.Client.Schema.UserForumSubscribedThreadsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      forumSubscribedThreads:
        Map.get(data, "forumSubscribedThreads")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ForumSubscribedThread})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
