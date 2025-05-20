defmodule Torngen.Client.Schema.UserCrimeUniques do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :rewards,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          rewards: Torngen.Client.Schema.UserCrimeUniquesReward.t(),
          id: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rewards: Map.get(data, "rewards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCrimeUniquesReward),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
