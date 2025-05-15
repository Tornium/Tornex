defmodule Torngen.Client.Schema.UserLookupResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :selections
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.UserSelectionName.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      selections: Map.get(data, "selections")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
