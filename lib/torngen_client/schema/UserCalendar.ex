defmodule Torngen.Client.Schema.UserCalendar do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :start_time
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          start_time: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start_time: Map.get(data, "start_time") |> Torngen.Client.Schema.parse({:static, :string})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
