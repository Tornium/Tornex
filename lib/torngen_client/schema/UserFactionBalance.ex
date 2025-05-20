defmodule Torngen.Client.Schema.UserFactionBalance do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :points,
    :money
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          points: integer(),
          money: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      points: Map.get(data, "points") |> Torngen.Client.Schema.parse({:static, :integer}),
      money: Map.get(data, "money") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
