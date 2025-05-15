defmodule Torngen.Client.Schema.FactionCrimeUser do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :progress,
    :outcome,
    :joined_at,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          progress: integer() | float(),
          outcome: nil | Torngen.Client.Schema.FactionCrimeUserOutcome.t(),
          joined_at: integer(),
          id: Torngen.Client.Schema.UserId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      progress: Map.get(data, "progress"),
      outcome: Map.get(data, "outcome"),
      joined_at: Map.get(data, "joined_at"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
