defmodule Torngen.Client.Schema.FactionHofStats do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :rank,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          respect: Torngen.Client.Schema.HofValue.t(),
          rank: Torngen.Client.Schema.HofValueString.t(),
          chain: Torngen.Client.Schema.HofValue.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValueString),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
