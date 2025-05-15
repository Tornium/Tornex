defmodule Torngen.Client.Schema.FactionWarsResponse do
  @moduledoc """
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
      wars: Map.get(data, "wars"),
      pacts: Map.get(data, "pacts")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
