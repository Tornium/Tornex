defmodule Torngen.Client.Schema.ForumFeed do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user: Map.get(data, "user") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadAuthor),
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumFeedTypeEnum),
      title: Map.get(data, "title") |> Torngen.Client.Schema.parse({:static, :string}),
      timestamp: Map.get(data, "timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      thread_id: Map.get(data, "thread_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumThreadId),
      text: Map.get(data, "text") |> Torngen.Client.Schema.parse({:static, :string}),
      post_id: Map.get(data, "post_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ForumPostId),
      is_seen: Map.get(data, "is_seen") |> Torngen.Client.Schema.parse({:static, :boolean})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
