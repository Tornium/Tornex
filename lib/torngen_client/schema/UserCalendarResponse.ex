defmodule Torngen.Client.Schema.UserCalendarResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :calendar
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          calendar: Torngen.Client.Schema.UserCalendar.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      calendar: Map.get(data, "calendar") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCalendar)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
