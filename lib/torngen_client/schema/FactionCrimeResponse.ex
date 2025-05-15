defmodule Torngen.Client.Schema.FactionCrimeResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crime
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          crime: Torngen.Client.Schema.FactionCrime.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crime: Map.get(data, "crime")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
