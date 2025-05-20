defmodule Torngen.Client.Schema.FactionChainReportAttacker do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :id,
    :attacks
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          respect: Torngen.Client.Schema.FactionChainReportAttackerRespect.t(),
          id: Torngen.Client.Schema.UserId.t(),
          attacks: Torngen.Client.Schema.FactionChainReportAttackerAttacks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect:
        Map.get(data, "respect") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReportAttackerRespect),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      attacks:
        Map.get(data, "attacks") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReportAttackerAttacks)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
