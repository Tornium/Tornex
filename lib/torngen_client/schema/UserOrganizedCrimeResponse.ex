defmodule Torngen.Client.Schema.UserOrganizedCrimeResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :organizedCrime
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          organizedCrime: nil | Torngen.Client.Schema.FactionCrime.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      organizedCrime: Map.get(data, "organizedCrime")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
