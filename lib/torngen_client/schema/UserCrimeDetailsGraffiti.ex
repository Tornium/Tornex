defmodule Torngen.Client.Schema.UserCrimeDetailsGraffiti do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :most_graffiti_simultaneously,
    :most_graffiti_in_one_area,
    :graffiti_removed,
    :cost_to_city,
    :cans_used
  ]

  @type t :: %__MODULE__{
          most_graffiti_simultaneously: integer(),
          most_graffiti_in_one_area: integer(),
          graffiti_removed: integer(),
          cost_to_city: integer(),
          cans_used: integer()
        }
end
