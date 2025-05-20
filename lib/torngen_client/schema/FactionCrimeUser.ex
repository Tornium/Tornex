defmodule Torngen.Client.Schema.FactionCrimeUser do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :progress,
    :outcome,
    :joined_at,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          progress: integer() | float(),
          outcome: nil | Torngen.Client.Schema.FactionCrimeUserOutcome.t(),
          joined_at: integer(),
          id: Torngen.Client.Schema.UserId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      progress: Map.get(data, "progress") |> Torngen.Client.Schema.parse({:static, :number}),
      outcome:
        Map.get(data, "outcome")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUserOutcome]}),
      joined_at: Map.get(data, "joined_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
