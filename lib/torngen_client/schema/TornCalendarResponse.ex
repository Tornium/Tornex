defmodule Torngen.Client.Schema.TornCalendarResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :calendar
  ]

  @type t :: %__MODULE__{
          calendar: %{
            :events => [Torngen.Client.Schema.TornCalendarActivity.t()],
            :competitions => [Torngen.Client.Schema.TornCalendarActivity.t()]
          }
        }
end
