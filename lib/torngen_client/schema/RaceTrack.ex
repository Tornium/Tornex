defmodule Torngen.Client.Schema.RaceTrack do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :title,
    :id,
    :description
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          title: String.t(),
          id: Torngen.Client.Schema.RaceTrackId.t(),
          description: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: Map.get(data, "title"),
      id: Map.get(data, "id"),
      description: Map.get(data, "description")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
