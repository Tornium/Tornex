defmodule Torngen.Client.Schema.FactionBranchDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :upgrades,
    :order,
    :name,
    :multiplier
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          upgrades: [Torngen.Client.Schema.FactionUpgradeDetails.t()],
          order: integer(),
          name: String.t(),
          multiplier: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      upgrades: Map.get(data, "upgrades"),
      order: Map.get(data, "order"),
      name: Map.get(data, "name"),
      multiplier: Map.get(data, "multiplier")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
