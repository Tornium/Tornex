defmodule Torngen.Client.Schema.UserCalendarResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :calendar
  ]

  @type t :: %__MODULE__{
          calendar: Torngen.Client.Schema.UserCalendar.t()
        }
end
