defmodule Torngen.Client.Schema.PersonalStatsFinishingHits do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :finishing_hits
  ]

  @type t :: %__MODULE__{
          finishing_hits: %{
            :temporary => integer(),
            :sub_machine_guns => integer(),
            :slashing => integer(),
            :shotguns => integer(),
            :rifles => integer(),
            :pistols => integer(),
            :piercing => integer(),
            :mechanical => integer(),
            :machine_guns => integer(),
            :heavy_artillery => integer(),
            :hand_to_hand => integer(),
            :clubbing => integer()
          }
        }
end
