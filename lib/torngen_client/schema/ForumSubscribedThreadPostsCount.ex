defmodule Torngen.Client.Schema.ForumSubscribedThreadPostsCount do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :new
  ]

  @type t :: %__MODULE__{
          total: integer(),
          new: integer()
        }
end
