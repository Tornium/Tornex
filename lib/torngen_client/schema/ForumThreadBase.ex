defmodule Torngen.Client.Schema.ForumThreadBase do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      views: Map.get(data, "views") |> Torngen.Client.Schema.parse({:static, :integer}),
      title: Map.get(data, "title") |> Torngen.Client.Schema.parse({:static, :string}),
      rating: Map.get(data, "rating") |> Torngen.Client.Schema.parse({:static, :integer}),
      posts: Map.get(data, "posts") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_poster:
        Map.get(data, "last_poster")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ForumThreadAuthor]}),
      last_post_time:
        Map.get(data, "last_post_time") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      is_sticky: Map.get(data, "is_sticky") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_locked: Map.get(data, "is_locked") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadId),
      has_poll: Map.get(data, "has_poll") |> Torngen.Client.Schema.parse({:static, :boolean}),
      forum_id: Map.get(data, "forum_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumId),
      first_post_time: Map.get(data, "first_post_time") |> Torngen.Client.Schema.parse({:static, :integer}),
      author: Map.get(data, "author") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadAuthor)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
