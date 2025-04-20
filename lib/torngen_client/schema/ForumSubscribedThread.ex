defmodule Torngen.Client.Schema.ForumSubscribedThread do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :title,
    :posts,
    :id,
    :forum_id,
    :author
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          posts: Torngen.Client.Schema.ForumSubscribedThreadPostsCount.t(),
          id: Torngen.Client.Schema.ForumThreadId.t(),
          forum_id: Torngen.Client.Schema.ForumId.t(),
          author: Torngen.Client.Schema.ForumThreadAuthor.t()
        }
end
