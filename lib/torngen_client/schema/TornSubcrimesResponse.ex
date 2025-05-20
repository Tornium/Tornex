defmodule Torngen.Client.Schema.TornSubcrimesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :subcrimes
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          subcrimes: [Torngen.Client.Schema.TornSubcrime.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      subcrimes: Map.get(data, "subcrimes") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornSubcrime})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
