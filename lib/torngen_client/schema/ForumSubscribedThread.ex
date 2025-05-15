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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          title: String.t(),
          posts: Torngen.Client.Schema.ForumSubscribedThreadPostsCount.t(),
          id: Torngen.Client.Schema.ForumThreadId.t(),
          forum_id: Torngen.Client.Schema.ForumId.t(),
          author: Torngen.Client.Schema.ForumThreadAuthor.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: Map.get(data, "title"),
      posts: Map.get(data, "posts"),
      id: Map.get(data, "id"),
      forum_id: Map.get(data, "forum_id"),
      author: Map.get(data, "author")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
