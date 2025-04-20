defmodule Torngen.Client.Schema.PersonalStatsDrugs do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :drugs
  ]

  @type t :: %__MODULE__{
          drugs: %{
            :xanax => integer(),
            :vicodin => integer(),
            :total => integer(),
            :speed => integer(),
            :shrooms => integer(),
            :rehabilitations => %{:fees => integer(), :amount => integer()},
            :pcp => integer(),
            :overdoses => integer(),
            :opium => integer(),
            :lsd => integer(),
            :ketamine => integer(),
            :ecstasy => integer(),
            :cannabis => integer()
          }
        }
end
