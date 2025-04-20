defmodule Torngen.Client.Schema.UserCrimeUniques do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :rewards,
    :id
  ]

  @type t :: %__MODULE__{
          rewards: [Torngen.Client.Schema.UserCrimeUniquesReward.t()],
          id: integer()
        }
end
