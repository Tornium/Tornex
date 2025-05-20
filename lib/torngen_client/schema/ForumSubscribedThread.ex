defmodule Torngen.Client.Schema.ForumSubscribedThread do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:title, :posts, :id, :forum_id, :author]

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

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:title, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:posts, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ForumSubscribedThreadPostsCount)
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ForumThreadId)
  end

  defp validate_key(:forum_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ForumId)
  end

  defp validate_key(:author, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ForumThreadAuthor)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
