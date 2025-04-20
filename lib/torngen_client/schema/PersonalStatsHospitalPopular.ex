defmodule Torngen.Client.Schema.PersonalStatsHospitalPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hospital
  ]

  @type t :: %__MODULE__{
          hospital: %{:reviving => %{:skill => integer(), :revives => integer()}, :medical_items_used => integer()}
        }
end
