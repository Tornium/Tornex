defmodule Torngen.Client.Schema.UserForumFeedResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:forumFeed]

  defstruct [
    :forumFeed
  ]

  @type t :: %__MODULE__{
          forumFeed: [Torngen.Client.Schema.ForumFeed.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      forumFeed: Map.get(data, "forumFeed") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ForumFeed})
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:forumFeed, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.ForumFeed})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
