defmodule Torngen.Client.Schema.ForumFeed do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:user, :type, :title, :timestamp, :thread_id, :text, :post_id, :is_seen]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user: data |> Map.get("user") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadAuthor),
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumFeedTypeEnum),
      title: data |> Map.get("title") |> Torngen.Client.Schema.parse({:static, :string}),
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      thread_id: data |> Map.get("thread_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadId),
      text: data |> Map.get("text") |> Torngen.Client.Schema.parse({:static, :string}),
      post_id: data |> Map.get("post_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumPostId),
      is_seen: data |> Map.get("is_seen") |> Torngen.Client.Schema.parse({:static, :boolean})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:user, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumThreadAuthor)
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumFeedTypeEnum)
  end

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:thread_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumThreadId)
  end

  defp validate_key?(:text, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:post_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ForumPostId)
  end

  defp validate_key?(:is_seen, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
