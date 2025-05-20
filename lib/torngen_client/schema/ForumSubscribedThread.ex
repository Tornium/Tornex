defmodule Torngen.Client.Schema.ForumSubscribedThread do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      title: Map.get(data, "title") |> Torngen.Client.Schema.parse({:static, :string}),
      posts:
        Map.get(data, "posts") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumSubscribedThreadPostsCount),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadId),
      forum_id: Map.get(data, "forum_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumId),
      author: Map.get(data, "author") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadAuthor)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
