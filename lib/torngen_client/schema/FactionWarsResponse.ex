defmodule Torngen.Client.Schema.FactionWarsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :wars,
    :pacts
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          wars: Torngen.Client.Schema.FactionWars.t(),
          pacts: [Torngen.Client.Schema.FactionPact.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      wars: Map.get(data, "wars") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionWars),
      pacts: Map.get(data, "pacts") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionPact})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
