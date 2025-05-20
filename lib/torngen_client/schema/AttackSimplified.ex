defmodule Torngen.Client.Schema.AttackSimplified do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :started,
    :result,
    :respect_loss,
    :respect_gain,
    :id,
    :ended,
    :defender,
    :code,
    :attacker
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          started: integer(),
          result: Torngen.Client.Schema.FactionAttackResult.t(),
          respect_loss: integer() | float(),
          respect_gain: integer() | float(),
          id: Torngen.Client.Schema.AttackId.t(),
          ended: integer(),
          defender: Torngen.Client.Schema.AttackPlayerSimplified.t(),
          code: Torngen.Client.Schema.AttackCode.t(),
          attacker: nil | Torngen.Client.Schema.AttackPlayerSimplified.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      started: Map.get(data, "started") |> Torngen.Client.Schema.parse({:static, :integer}),
      result: Map.get(data, "result") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionAttackResult),
      respect_loss: Map.get(data, "respect_loss") |> Torngen.Client.Schema.parse({:static, :number}),
      respect_gain: Map.get(data, "respect_gain") |> Torngen.Client.Schema.parse({:static, :number}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackId),
      ended: Map.get(data, "ended") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender: Map.get(data, "defender") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackPlayerSimplified),
      code: Map.get(data, "code") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackCode),
      attacker:
        Map.get(data, "attacker")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayerSimplified]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
