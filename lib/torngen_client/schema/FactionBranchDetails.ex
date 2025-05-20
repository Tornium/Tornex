defmodule Torngen.Client.Schema.FactionBranchDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      upgrades:
        Map.get(data, "upgrades") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionUpgradeDetails}),
      order: Map.get(data, "order") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      multiplier: Map.get(data, "multiplier") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
