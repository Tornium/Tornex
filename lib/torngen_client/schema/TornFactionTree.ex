defmodule Torngen.Client.Schema.TornFactionTree do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :branches
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          name: String.t(),
          branches: [Torngen.Client.Schema.TornFactionTreeBranch.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name"),
      branches: Map.get(data, "branches")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
