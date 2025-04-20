defmodule Torngen.Client.Schema.ForumPollVote do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :votes,
    :answer
  ]

  @type t :: %__MODULE__{
          votes: integer(),
          answer: String.t()
        }
end
