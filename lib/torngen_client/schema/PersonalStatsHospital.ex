defmodule Torngen.Client.Schema.PersonalStatsHospital do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hospital
  ]

  @type t :: %__MODULE__{
          hospital: %{
            :times_hospitalized => integer(),
            :reviving => %{:skill => integer(), :revives_received => integer(), :revives => integer()},
            :medical_items_used => integer(),
            :blood_withdrawn => integer()
          }
        }
end
