defmodule Torngen.Client.Schema.FactionHofValues do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :chain_duration,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          respect: nil | integer(),
          chain_duration: nil | integer(),
          chain: nil | integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      chain_duration:
        Map.get(data, "chain_duration") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
