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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      views: Map.get(data, "views"),
      title: Map.get(data, "title"),
      rating: Map.get(data, "rating"),
      posts: Map.get(data, "posts"),
      last_poster: Map.get(data, "last_poster"),
      last_post_time: Map.get(data, "last_post_time"),
      is_sticky: Map.get(data, "is_sticky"),
      is_locked: Map.get(data, "is_locked"),
      id: Map.get(data, "id"),
      has_poll: Map.get(data, "has_poll"),
      forum_id: Map.get(data, "forum_id"),
      first_post_time: Map.get(data, "first_post_time"),
      author: Map.get(data, "author")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
