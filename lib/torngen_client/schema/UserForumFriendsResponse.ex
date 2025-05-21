defmodule Torngen.Client.Schema.UserForumFriendsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:forumFriends]

  defstruct [
    :forumFriends
  ]

  @type t :: %__MODULE__{
          forumFriends: [Torngen.Client.Schema.ForumFeed.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      forumFriends:
        data |> Map.get("forumFriends") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ForumFeed})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:forumFriends, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ForumFeed})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
