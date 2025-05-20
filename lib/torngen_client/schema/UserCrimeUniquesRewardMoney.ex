defmodule Torngen.Client.Schema.UserCrimeUniquesRewardMoney do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :min,
    :max
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          min: integer(),
          max: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      min: Map.get(data, "min") |> Torngen.Client.Schema.parse({:static, :integer}),
      max: Map.get(data, "max") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
