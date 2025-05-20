defmodule Torngen.Client.Schema.TornItemBaseStats do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :damage,
    :armor,
    :accuracy
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          damage: integer(),
          armor: integer(),
          accuracy: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      damage: Map.get(data, "damage") |> Torngen.Client.Schema.parse({:static, :integer}),
      armor: Map.get(data, "armor") |> Torngen.Client.Schema.parse({:static, :integer}),
      accuracy: Map.get(data, "accuracy") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
