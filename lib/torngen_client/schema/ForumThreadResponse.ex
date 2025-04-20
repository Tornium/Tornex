defmodule Torngen.Client.Schema.ForumThreadResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :thread
  ]

  @type t :: %__MODULE__{
          thread: Torngen.Client.Schema.ForumThreadExtended.t()
        }
end
