defmodule Torngen.Client.Schema.FactionUpgradeDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :unlocked_at,
    :name,
    :level,
    :id,
    :cost,
    :ability
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          unlocked_at: integer(),
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.FactionBranchId.t(),
          cost: integer(),
          ability: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      unlocked_at: Map.get(data, "unlocked_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBranchId),
      cost: Map.get(data, "cost") |> Torngen.Client.Schema.parse({:static, :integer}),
      ability: Map.get(data, "ability") |> Torngen.Client.Schema.parse({:static, :string})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
