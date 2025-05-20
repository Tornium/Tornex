defmodule Torngen.Client.Schema.UserForumFriendsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :forumFriends
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          forumFriends: [Torngen.Client.Schema.ForumFeed.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      forumFriends:
        Map.get(data, "forumFriends") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ForumFeed})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
