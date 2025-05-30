defmodule Torngen.Client.Schema.ForumThreadBase do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      views: data |> Map.get("views") |> Torngen.Client.Schema.parse({:static, :integer}),
      title: data |> Map.get("title") |> Torngen.Client.Schema.parse({:static, :string}),
      rating: data |> Map.get("rating") |> Torngen.Client.Schema.parse({:static, :integer}),
      posts: data |> Map.get("posts") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_poster:
        data
        |> Map.get("last_poster")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ForumThreadAuthor]}),
      last_post_time:
        data |> Map.get("last_post_time") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      is_sticky: data |> Map.get("is_sticky") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_locked: data |> Map.get("is_locked") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadId),
      has_poll: data |> Map.get("has_poll") |> Torngen.Client.Schema.parse({:static, :boolean}),
      forum_id: data |> Map.get("forum_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumId),
      first_post_time: data |> Map.get("first_post_time") |> Torngen.Client.Schema.parse({:static, :integer}),
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

  defp validate_key?(:views, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:rating, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:posts, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:last_poster, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.ForumThreadAuthor]})
  end

  defp validate_key?(:last_post_time, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:is_sticky, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_locked, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumThreadId)
  end

  defp validate_key?(:has_poll, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:forum_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumId)
  end

  defp validate_key?(:first_post_time, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:author, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumThreadAuthor)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
