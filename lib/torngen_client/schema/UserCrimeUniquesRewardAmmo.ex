defmodule Torngen.Client.Schema.UserCrimeUniquesRewardAmmo do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :type,
    :amount
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum.t(),
          amount: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type"),
      amount: Map.get(data, "amount")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
