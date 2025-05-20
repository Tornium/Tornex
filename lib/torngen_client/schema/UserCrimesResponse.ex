defmodule Torngen.Client.Schema.UserCrimesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crimes
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          crimes: Torngen.Client.Schema.UserCrime.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crimes: Map.get(data, "crimes") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrime)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
