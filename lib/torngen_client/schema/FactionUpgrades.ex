defmodule Torngen.Client.Schema.FactionUpgrades do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war,
    :peace,
    :core
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          war: [Torngen.Client.Schema.FactionBranchDetails.t()],
          peace: [Torngen.Client.Schema.FactionBranchDetails.t()],
          core: %{:upgrades => [Torngen.Client.Schema.FactionUpgradeDetails.t()]}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war: Map.get(data, "war"),
      peace: Map.get(data, "peace"),
      core: Map.get(data, "core")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
