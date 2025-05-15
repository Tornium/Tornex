defmodule Torngen.Client.Schema.FactionCrime do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :status,
    :slots,
    :rewards,
    :ready_at,
    :previous_crime_id,
    :planning_at,
    :name,
    :id,
    :expired_at,
    :executed_at,
    :difficulty,
    :created_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.FactionCrimeStatusEnum.t(),
          slots: [Torngen.Client.Schema.FactionCrimeSlot.t()],
          rewards: nil | Torngen.Client.Schema.FactionCrimeReward.t(),
          ready_at: nil | integer(),
          previous_crime_id: nil | Torngen.Client.Schema.FactionCrimeId.t(),
          planning_at: nil | integer(),
          name: String.t(),
          id: Torngen.Client.Schema.FactionCrimeId.t(),
          expired_at: integer(),
          executed_at: nil | integer(),
          difficulty: integer(),
          created_at: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status: Map.get(data, "status"),
      slots: Map.get(data, "slots"),
      rewards: Map.get(data, "rewards"),
      ready_at: Map.get(data, "ready_at"),
      previous_crime_id: Map.get(data, "previous_crime_id"),
      planning_at: Map.get(data, "planning_at"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      expired_at: Map.get(data, "expired_at"),
      executed_at: Map.get(data, "executed_at"),
      difficulty: Map.get(data, "difficulty"),
      created_at: Map.get(data, "created_at")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
