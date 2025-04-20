defmodule Torngen.Client.Schema.ForumPostsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :posts,
    :_metadata
  ]

  @type t :: %__MODULE__{
          posts: [Torngen.Client.Schema.ForumPost.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
