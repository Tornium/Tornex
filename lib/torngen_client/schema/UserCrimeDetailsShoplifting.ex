defmodule Torngen.Client.Schema.UserCrimeDetailsShoplifting do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :average_notoriety
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          average_notoriety: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      average_notoriety: Map.get(data, "average_notoriety") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
