defmodule Torngen.Client.Schema.UserForumFriendsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumFriends
  ]

  @type t :: %__MODULE__{
          forumFriends: [Torngen.Client.Schema.ForumFeed.t()]
        }
end
