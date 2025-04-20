defmodule Torngen.Client.Schema.UserForumSubscribedThreadsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumSubscribedThreads
  ]

  @type t :: %__MODULE__{
          forumSubscribedThreads: [Torngen.Client.Schema.ForumSubscribedThread.t()]
        }
end
