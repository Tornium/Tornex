defmodule Torngen.Client.Schema.Bounty do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :valid_until,
    :target_name,
    :target_level,
    :target_id,
    :reward,
    :reason,
    :quantity,
    :lister_name,
    :lister_id,
    :is_anonymous
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          valid_until: integer(),
          target_name: String.t(),
          target_level: integer(),
          target_id: Torngen.Client.Schema.UserId.t(),
          reward: integer(),
          reason: nil | String.t(),
          quantity: integer(),
          lister_name: nil | String.t(),
          lister_id: nil | Torngen.Client.Schema.UserId.t(),
          is_anonymous: boolean()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      valid_until: Map.get(data, "valid_until"),
      target_name: Map.get(data, "target_name"),
      target_level: Map.get(data, "target_level"),
      target_id: Map.get(data, "target_id"),
      reward: Map.get(data, "reward"),
      reason: Map.get(data, "reason"),
      quantity: Map.get(data, "quantity"),
      lister_name: Map.get(data, "lister_name"),
      lister_id: Map.get(data, "lister_id"),
      is_anonymous: Map.get(data, "is_anonymous")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
