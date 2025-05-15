defmodule Torngen.Client.Schema.ForumPoll do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :question,
    :answers_count,
    :answers
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          question: String.t(),
          answers_count: integer(),
          answers: [Torngen.Client.Schema.ForumPollVote.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      question: Map.get(data, "question"),
      answers_count: Map.get(data, "answers_count"),
      answers: Map.get(data, "answers")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
