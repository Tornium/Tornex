defmodule Torngen.Client.Schema.PersonalStatsItemsPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :items
  ]

  @type t :: %__MODULE__{
          items: %{
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
            :found => %{:dump => integer()}
          }
        }
end
