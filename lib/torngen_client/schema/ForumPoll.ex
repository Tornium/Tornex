defmodule Torngen.Client.Schema.ForumPoll do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      question: Map.get(data, "question") |> Torngen.Client.Schema.parse({:static, :string}),
      answers_count: Map.get(data, "answers_count") |> Torngen.Client.Schema.parse({:static, :integer}),
      answers: Map.get(data, "answers") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ForumPollVote})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
