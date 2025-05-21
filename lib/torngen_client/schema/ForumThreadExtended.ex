defmodule Torngen.Client.Schema.ForumThreadExtended do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            Torngen.Client.Schema.ForumThreadBase.t()
            | %{:poll => nil | Torngen.Client.Schema.ForumPoll.t(), :content_raw => String.t(), :content => String.t()}
          ]
        }
end
