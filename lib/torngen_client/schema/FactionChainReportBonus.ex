defmodule Torngen.Client.Schema.FactionChainReportBonus do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :defender_id,
    :chain,
    :attacker_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          respect: integer(),
          defender_id: Torngen.Client.Schema.UserId.t(),
          chain: integer(),
          attacker_id: Torngen.Client.Schema.UserId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender_id: Map.get(data, "defender_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse({:static, :integer}),
      attacker_id: Map.get(data, "attacker_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
