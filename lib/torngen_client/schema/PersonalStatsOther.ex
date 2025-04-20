defmodule Torngen.Client.Schema.PersonalStatsOther do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :other
  ]

  @type t :: %__MODULE__{
          other: %{
            :refills => %{:token => integer(), :nerve => integer(), :energy => integer()},
            :ranked_war_wins => integer(),
            :merits_bought => integer(),
            :donator_days => integer(),
            :awards => integer(),
            :activity => %{:time => integer(), :streak => %{:current => integer(), :best => integer()}}
          }
        }
end
