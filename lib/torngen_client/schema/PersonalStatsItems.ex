defmodule Torngen.Client.Schema.PersonalStatsItems do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :items
  ]

  @type t :: %__MODULE__{
          items: %{
            :viruses_coded => integer(),
            :used => %{
              :stat_enhancers => integer(),
              :energy_drinks => integer(),
              :easter_eggs => integer(),
              :consumables => integer(),
              :candy => integer(),
              :boosters => integer(),
              :books => integer(),
              :alcohol => integer()
            },
            :trashed => integer(),
            :found => %{:easter_eggs => integer(), :dump => integer(), :city => integer()}
          }
        }
end
