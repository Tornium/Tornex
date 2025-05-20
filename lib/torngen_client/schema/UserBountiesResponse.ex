defmodule Torngen.Client.Schema.UserBountiesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :bounties
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          bounties: [Torngen.Client.Schema.Bounty.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bounties: Map.get(data, "bounties") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.Bounty})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
