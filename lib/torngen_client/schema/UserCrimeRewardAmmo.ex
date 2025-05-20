defmodule Torngen.Client.Schema.UserCrimeRewardAmmo do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :standard,
    :special
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          standard: integer(),
          special: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      standard: Map.get(data, "standard") |> Torngen.Client.Schema.parse({:static, :integer}),
      special: Map.get(data, "special") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
