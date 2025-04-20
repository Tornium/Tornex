defmodule Torngen.Client.Schema.TornItemArmorCoverage do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :name
  ]

  @type t :: %__MODULE__{
          value: integer() | float(),
          name: Torngen.Client.Schema.TornItemArmorCoveragePartEnum.t()
        }
end
