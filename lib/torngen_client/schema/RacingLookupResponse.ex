defmodule Torngen.Client.Schema.RacingLookupResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :selections
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.RacingSelectionName.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      selections:
        Map.get(data, "selections") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RacingSelectionName})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
