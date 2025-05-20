defmodule Torngen.Client.Schema.FactionBalanceResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :balance
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          balance: Torngen.Client.Schema.FactionBalance.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      balance: Map.get(data, "balance") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBalance)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
