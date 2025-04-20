defmodule Torngen.Client.Schema.UserBountiesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :bounties
  ]

  @type t :: %__MODULE__{
          bounties: [Torngen.Client.Schema.Bounty.t()]
        }
end
