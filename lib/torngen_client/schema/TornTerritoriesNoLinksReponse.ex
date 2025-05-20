defmodule Torngen.Client.Schema.TornTerritoriesNoLinksReponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territory
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.TornTerritory.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory:
        Map.get(data, "territory") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornTerritory})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
