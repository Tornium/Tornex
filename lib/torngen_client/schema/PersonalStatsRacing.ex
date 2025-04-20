defmodule Torngen.Client.Schema.PersonalStatsRacing do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :racing
  ]

  @type t :: %__MODULE__{
          racing: %{:skill => integer(), :races => %{:won => integer(), :entered => integer()}, :points => integer()}
        }
end
