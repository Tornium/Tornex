defmodule Torngen.Client.Schema.AttackSimplified do
  @moduledoc """
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
      started: Map.get(data, "started"),
      result: Map.get(data, "result"),
      respect_loss: Map.get(data, "respect_loss"),
      respect_gain: Map.get(data, "respect_gain"),
      id: Map.get(data, "id"),
      ended: Map.get(data, "ended"),
      defender: Map.get(data, "defender"),
      code: Map.get(data, "code"),
      attacker: Map.get(data, "attacker")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
