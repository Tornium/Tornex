defmodule Torngen.Client.Schema.FactionMembersResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :members
  ]

  @type t :: %__MODULE__{
          members: [Torngen.Client.Schema.FactionMember.t()]
        }
end
