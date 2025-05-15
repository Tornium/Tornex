defmodule Torngen.Client.Schema.ForumFeed do
  @moduledoc """
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
      user: Map.get(data, "user"),
      type: Map.get(data, "type"),
      title: Map.get(data, "title"),
      timestamp: Map.get(data, "timestamp"),
      thread_id: Map.get(data, "thread_id"),
      text: Map.get(data, "text"),
      post_id: Map.get(data, "post_id"),
      is_seen: Map.get(data, "is_seen")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
