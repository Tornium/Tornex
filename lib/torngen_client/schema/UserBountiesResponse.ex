defmodule Torngen.Client.Schema.UserBountiesResponse do
  @moduledoc """
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
      bounties: Map.get(data, "bounties")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
