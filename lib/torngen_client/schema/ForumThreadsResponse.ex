defmodule Torngen.Client.Schema.ForumThreadsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :threads,
    :_metadata
  ]

  @type t :: %__MODULE__{
          threads: [Torngen.Client.Schema.ForumThreadBase.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
