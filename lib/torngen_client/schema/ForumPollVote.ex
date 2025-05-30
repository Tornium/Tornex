defmodule Torngen.Client.Schema.ForumPollVote do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:votes, :answer]

  defstruct [
    :votes,
    :answer
  ]

  @type t :: %__MODULE__{
          votes: integer(),
          answer: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      votes: data |> Map.get("votes") |> Torngen.Client.Schema.parse({:static, :integer}),
      answer: data |> Map.get("answer") |> Torngen.Client.Schema.parse({:static, :string})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:votes, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:answer, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
