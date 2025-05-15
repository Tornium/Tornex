defmodule Torngen.Client.Schema.UserForumFeedResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumFeed
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          forumFeed: [Torngen.Client.Schema.ForumFeed.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      forumFeed: Map.get(data, "forumFeed")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
