defmodule Torngen.Client.Schema.ForumThreadUserExtended do
  @moduledoc """
  [SHORT DESCRIPTION]

  Type: AllOf
  """

  @behaviour Torngen.Client.Schema

  @type t :: [Torngen.Client.Schema.ForumThreadBase.t() | %{:new_posts => nil | integer()}]
end
