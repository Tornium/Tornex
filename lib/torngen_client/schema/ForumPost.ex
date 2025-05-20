defmodule Torngen.Client.Schema.ForumPost do
  @moduledoc """
  [SHORT DESCRIPTION]
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
end
