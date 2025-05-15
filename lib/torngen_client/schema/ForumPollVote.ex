defmodule Torngen.Client.Schema.ForumPollVote do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :votes,
    :answer
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          votes: integer(),
          answer: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      votes: Map.get(data, "votes"),
      answer: Map.get(data, "answer")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
