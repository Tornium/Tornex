defmodule Torngen.Client.Schema.FactionPact do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :until,
    :faction_name,
    :faction_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          until: String.t(),
          faction_name: String.t(),
          faction_id: Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: Map.get(data, "until"),
      faction_name: Map.get(data, "faction_name"),
      faction_id: Map.get(data, "faction_id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
