defmodule Torngen.Client.Schema.ForumSubscribedThread do
  @moduledoc false

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
      title: data |> Map.get("title") |> Torngen.Client.Schema.parse({:static, :string}),
      posts:
        data |> Map.get("posts") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumSubscribedThreadPostsCount),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadId),
      forum_id: data |> Map.get("forum_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumId),
      author: data |> Map.get("author") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadAuthor)
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:posts, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumSubscribedThreadPostsCount)
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumThreadId)
  end

  defp validate_key?(:forum_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumId)
  end

  defp validate_key?(:author, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumThreadAuthor)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
