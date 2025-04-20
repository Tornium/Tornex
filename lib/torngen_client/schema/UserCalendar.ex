defmodule Torngen.Client.Schema.UserCalendar do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :start_time
  ]

  @type t :: %__MODULE__{
          start_time: String.t()
        }
end
