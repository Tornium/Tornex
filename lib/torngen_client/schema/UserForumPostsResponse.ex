defmodule Torngen.Client.Schema.UserForumPostsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumPosts,
    :_metadata
  ]

  @type t :: %__MODULE__{
          forumPosts: [Torngen.Client.Schema.ForumPost.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
