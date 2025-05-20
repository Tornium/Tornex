defmodule Torngen.Client.Schema.TornCalendarResponse do
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
          calendar: %{
            :events => [Torngen.Client.Schema.TornCalendarActivity.t()],
            :competitions => [Torngen.Client.Schema.TornCalendarActivity.t()]
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      calendar:
        Map.get(data, "calendar")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "competitions" => {:array, Torngen.Client.Schema.TornCalendarActivity},
             "events" => {:array, Torngen.Client.Schema.TornCalendarActivity}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
