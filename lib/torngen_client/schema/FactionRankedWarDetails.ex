defmodule Torngen.Client.Schema.FactionRankedWarDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :target,
    :start,
    :id,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          target: integer(),
          start: integer(),
          id: Torngen.Client.Schema.RankedWarId.t(),
          factions: [
            %{:score => integer(), :name => String.t(), :id => Torngen.Client.Schema.FactionId.t(), :chain => integer()}
          ],
          end: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner: Map.get(data, "winner"),
      target: Map.get(data, "target"),
      start: Map.get(data, "start"),
      id: Map.get(data, "id"),
      factions: Map.get(data, "factions"),
      end: Map.get(data, "end")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
