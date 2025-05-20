defmodule Torngen.Client.Schema.FactionCrimeResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      crime: Map.get(data, "crime") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionCrime)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
