defmodule Torngen.Client.Schema.ForumPost do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      thread_id: Map.get(data, "thread_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadId),
      quoted_post_id:
        Map.get(data, "quoted_post_id") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      likes: Map.get(data, "likes") |> Torngen.Client.Schema.parse({:static, :integer}),
      is_topic: Map.get(data, "is_topic") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_pinned: Map.get(data, "is_pinned") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_legacy: Map.get(data, "is_legacy") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_edited: Map.get(data, "is_edited") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumPostId),
      has_quote: Map.get(data, "has_quote") |> Torngen.Client.Schema.parse({:static, :boolean}),
      edited_by:
        Map.get(data, "edited_by")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      dislikes: Map.get(data, "dislikes") |> Torngen.Client.Schema.parse({:static, :integer}),
      created_time: Map.get(data, "created_time") |> Torngen.Client.Schema.parse({:static, :integer}),
      content: Map.get(data, "content") |> Torngen.Client.Schema.parse({:static, :string}),
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

  defp validate_key(:thread_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ForumThreadId)
  end

  defp validate_key(:quoted_post_id, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key(:likes, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:is_topic, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:is_pinned, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:is_legacy, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:is_edited, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ForumPostId)
  end

  defp validate_key(:has_quote, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:edited_by, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]})
  end

  defp validate_key(:dislikes, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:created_time, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:content, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:author, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ForumThreadAuthor)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
