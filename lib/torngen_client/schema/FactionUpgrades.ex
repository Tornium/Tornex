defmodule Torngen.Client.Schema.FactionUpgrades do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      war: Map.get(data, "war") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionBranchDetails}),
      peace:
        Map.get(data, "peace") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionBranchDetails}),
      core:
        Map.get(data, "core")
        |> Torngen.Client.Schema.parse(
          {:object, %{"upgrades" => {:array, Torngen.Client.Schema.FactionUpgradeDetails}}}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
