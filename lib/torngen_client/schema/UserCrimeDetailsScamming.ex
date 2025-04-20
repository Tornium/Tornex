defmodule Torngen.Client.Schema.UserCrimeDetailsScamming do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :zones,
    :payouts,
    :most_responses,
    :emails,
    :concerns
  ]

  @type t :: %__MODULE__{
          zones: %{
            :temptation => integer(),
            :sensitivity => integer(),
            :red => integer(),
            :neutral => integer(),
            :medium_reward => integer(),
            :low_reward => integer(),
            :high_reward => integer(),
            :hesitation => integer(),
            :concern => integer()
          },
          payouts: %{:medium => integer(), :low => integer(), :high => integer()},
          most_responses: integer(),
          emails: %{:scraper => integer(), :phisher => integer()},
          concerns: %{:resolved => integer(), :attempts => integer()}
        }
end
