defmodule Torngen.Client.Schema.ForumFeed do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :user,
    :type,
    :title,
    :timestamp,
    :thread_id,
    :text,
    :post_id,
    :is_seen
  ]

  @type t :: %__MODULE__{
          user: Torngen.Client.Schema.ForumThreadAuthor.t(),
          type: Torngen.Client.Schema.ForumFeedTypeEnum.t(),
          title: String.t(),
          timestamp: integer(),
          thread_id: Torngen.Client.Schema.ForumThreadId.t(),
          text: String.t(),
          post_id: Torngen.Client.Schema.ForumPostId.t(),
          is_seen: boolean()
        }
end
