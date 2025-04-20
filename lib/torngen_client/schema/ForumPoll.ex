defmodule Torngen.Client.Schema.ForumPoll do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :question,
    :answers_count,
    :answers
  ]

  @type t :: %__MODULE__{
          question: String.t(),
          answers_count: integer(),
          answers: [Torngen.Client.Schema.ForumPollVote.t()]
        }
end
