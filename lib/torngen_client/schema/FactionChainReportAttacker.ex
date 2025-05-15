defmodule Torngen.Client.Schema.FactionChainReportAttacker do
  @moduledoc """
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
      respect: Map.get(data, "respect"),
      id: Map.get(data, "id"),
      attacks: Map.get(data, "attacks")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
