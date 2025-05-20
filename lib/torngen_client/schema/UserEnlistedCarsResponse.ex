defmodule Torngen.Client.Schema.UserEnlistedCarsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :enlistedcars
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          enlistedcars: [Torngen.Client.Schema.UserRaceCarDetails.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      enlistedcars:
        Map.get(data, "enlistedcars") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserRaceCarDetails})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
