defmodule Torngen.Client.Schema.FactionChain do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :start,
    :respect,
    :id,
    :end,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          start: integer(),
          respect: integer() | float(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          chain: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :number}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ChainId),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer}),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
