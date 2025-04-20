defmodule Torngen.Client.Schema.ForumThreadAuthor do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :username,
    :karma,
    :id
  ]

  @type t :: %__MODULE__{
          username: String.t(),
          karma: integer(),
          id: Torngen.Client.Schema.UserId.t()
        }
end
