defmodule Torngen.Client.Schema.TornRacket do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :reward,
    :name,
    :level,
    :description,
    :created_at,
    :changed_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          reward: Torngen.Client.Schema.TornRacketReward.t(),
          name: String.t(),
          level: integer(),
          description: String.t(),
          created_at: integer(),
          changed_at: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      reward: Map.get(data, "reward"),
      name: Map.get(data, "name"),
      level: Map.get(data, "level"),
      description: Map.get(data, "description"),
      created_at: Map.get(data, "created_at"),
      changed_at: Map.get(data, "changed_at")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
