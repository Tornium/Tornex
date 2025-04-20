defmodule Torngen.Client.Schema.UserForumThreadsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumThreads,
    :_metadata
  ]

  @type t :: %__MODULE__{
          forumThreads: [Torngen.Client.Schema.ForumThreadUserExtended.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
