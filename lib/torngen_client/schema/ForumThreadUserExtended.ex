defmodule Torngen.Client.Schema.ForumThreadUserExtended do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{values: [Torngen.Client.Schema.ForumThreadBase.t() | %{:new_posts => nil | integer()}]}
end
