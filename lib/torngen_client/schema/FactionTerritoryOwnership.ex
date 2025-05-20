defmodule Torngen.Client.Schema.FactionTerritoryOwnership do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :owned_by,
    :id,
    :acquired_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          owned_by: nil | Torngen.Client.Schema.FactionId.t(),
          id: String.t(),
          acquired_at: nil | integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      owned_by:
        Map.get(data, "owned_by")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :string}),
      acquired_at:
        Map.get(data, "acquired_at") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
