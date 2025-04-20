defmodule Torngen.Client.Schema.ForumThreadBase do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :views,
    :title,
    :rating,
    :posts,
    :last_poster,
    :last_post_time,
    :is_sticky,
    :is_locked,
    :id,
    :has_poll,
    :forum_id,
    :first_post_time,
    :author
  ]

  @type t :: %__MODULE__{
          views: integer(),
          title: String.t(),
          rating: integer(),
          posts: integer(),
          last_poster: nil | Torngen.Client.Schema.ForumThreadAuthor.t(),
          last_post_time: nil | integer(),
          is_sticky: boolean(),
          is_locked: boolean(),
          id: Torngen.Client.Schema.ForumThreadId.t(),
          has_poll: boolean(),
          forum_id: Torngen.Client.Schema.ForumId.t(),
          first_post_time: integer(),
          author: Torngen.Client.Schema.ForumThreadAuthor.t()
        }
end
