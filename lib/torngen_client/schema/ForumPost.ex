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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      thread_id: Map.get(data, "thread_id"),
      quoted_post_id: Map.get(data, "quoted_post_id"),
      likes: Map.get(data, "likes"),
      is_topic: Map.get(data, "is_topic"),
      is_pinned: Map.get(data, "is_pinned"),
      is_legacy: Map.get(data, "is_legacy"),
      is_edited: Map.get(data, "is_edited"),
      id: Map.get(data, "id"),
      has_quote: Map.get(data, "has_quote"),
      edited_by: Map.get(data, "edited_by"),
      dislikes: Map.get(data, "dislikes"),
      created_time: Map.get(data, "created_time"),
      content: Map.get(data, "content"),
      author: Map.get(data, "author")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
