defmodule Torngen.Client.Schema.ForumPoll do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:question, :answers_count, :answers]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      question: data |> Map.get("question") |> Torngen.Client.Schema.parse({:static, :string}),
      answers_count: data |> Map.get("answers_count") |> Torngen.Client.Schema.parse({:static, :integer}),
      answers: data |> Map.get("answers") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ForumPollVote})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:question, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:answers_count, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:answers, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ForumPollVote})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
