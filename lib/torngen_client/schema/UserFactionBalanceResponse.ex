defmodule Torngen.Client.Schema.UserFactionBalanceResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :factionBalance
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          factionBalance: nil | Torngen.Client.Schema.UserFactionBalance.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      factionBalance: Map.get(data, "factionBalance")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
