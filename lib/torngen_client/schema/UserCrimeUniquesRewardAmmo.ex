defmodule Torngen.Client.Schema.UserCrimeUniquesRewardAmmo do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum),
      amount: Map.get(data, "amount") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
