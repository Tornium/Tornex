defmodule Torngen.Client.Schema.ForumPost do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :thread_id,
    :quoted_post_id,
    :likes,
    :is_topic,
    :is_pinned,
    :is_legacy,
    :is_edited,
    :id,
    :has_quote,
    :edited_by,
    :dislikes,
    :created_time,
    :content,
    :author
  ]

  @type t :: %__MODULE__{
          thread_id: Torngen.Client.Schema.ForumThreadId.t(),
          quoted_post_id: nil | integer(),
          likes: integer(),
          is_topic: boolean(),
          is_pinned: boolean(),
          is_legacy: boolean(),
          is_edited: boolean(),
          id: Torngen.Client.Schema.ForumPostId.t(),
          has_quote: boolean(),
          edited_by: nil | Torngen.Client.Schema.UserId.t(),
          dislikes: integer(),
          created_time: integer(),
          content: String.t(),
          author: Torngen.Client.Schema.ForumThreadAuthor.t()
        }
end
