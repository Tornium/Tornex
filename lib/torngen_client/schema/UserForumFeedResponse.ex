defmodule Torngen.Client.Schema.UserForumFeedResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumFeed
  ]

  @type t :: %__MODULE__{
          forumFeed: [Torngen.Client.Schema.ForumFeed.t()]
        }
end
