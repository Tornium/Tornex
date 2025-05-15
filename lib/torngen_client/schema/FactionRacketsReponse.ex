defmodule Torngen.Client.Schema.FactionRacketsReponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :rackets
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          rackets: [Torngen.Client.Schema.TornRacket.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rackets: Map.get(data, "rackets")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
