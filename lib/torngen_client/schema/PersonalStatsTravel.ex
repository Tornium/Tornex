defmodule Torngen.Client.Schema.PersonalStatsTravel do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :travel
  ]

  @type t :: %__MODULE__{
          travel: %{
            :united_kingdom => integer(),
            :united_arab_emirates => integer(),
            :total => integer(),
            :time_spent => integer(),
            :switzerland => integer(),
            :south_africa => integer(),
            :mexico => integer(),
            :japan => integer(),
            :items_bought => integer(),
            :hunting => %{:skill => integer()},
            :hawaii => integer(),
            :defends_lost => integer(),
            :china => integer(),
            :cayman_islands => integer(),
            :canada => integer(),
            :attacks_won => integer(),
            :argentina => integer()
          }
        }
end
