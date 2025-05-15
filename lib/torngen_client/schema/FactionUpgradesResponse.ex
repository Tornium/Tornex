defmodule Torngen.Client.Schema.FactionUpgradesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :upgrades,
    :state
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          upgrades: Torngen.Client.Schema.FactionUpgrades.t(),
          state: Torngen.Client.Schema.FactionBranchStateEnum.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      upgrades: Map.get(data, "upgrades"),
      state: Map.get(data, "state")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
