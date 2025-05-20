defmodule Torngen.Client.Schema.AttackLogSummary do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :misses,
    :id,
    :hits,
    :damage
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          name: nil | String.t(),
          misses: integer(),
          id: nil | Torngen.Client.Schema.UserId.t(),
          hits: integer(),
          damage: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      misses: Map.get(data, "misses") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        Map.get(data, "id") |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      hits: Map.get(data, "hits") |> Torngen.Client.Schema.parse({:static, :integer}),
      damage: Map.get(data, "damage") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
