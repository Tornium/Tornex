defmodule Torngen.Client.Schema.ForumThreadExtended do
  @moduledoc """
  [SHORT DESCRIPTION]

  Type: AllOf
  """

  @behaviour Torngen.Client.Schema

  @type t :: [
          Torngen.Client.Schema.ForumThreadBase.t()
          | %{:poll => nil | Torngen.Client.Schema.ForumPoll.t(), :content_raw => String.t(), :content => String.t()}
        ]
end
