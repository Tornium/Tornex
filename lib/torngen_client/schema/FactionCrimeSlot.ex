defmodule Torngen.Client.Schema.FactionCrimeSlot do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :user_id,
    :user,
    :success_chance,
    :position,
    :item_requirement,
    :crime_pass_rate,
    :checkpoint_pass_rate
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          user_id: nil | Torngen.Client.Schema.UserId.t(),
          user: nil | Torngen.Client.Schema.FactionCrimeUser.t(),
          success_chance: integer(),
          position: String.t(),
          item_requirement:
            nil | %{:is_reusable => boolean(), :is_available => boolean(), :id => Torngen.Client.Schema.ItemId.t()},
          crime_pass_rate: integer(),
          checkpoint_pass_rate: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user_id: Map.get(data, "user_id"),
      user: Map.get(data, "user"),
      success_chance: Map.get(data, "success_chance"),
      position: Map.get(data, "position"),
      item_requirement: Map.get(data, "item_requirement"),
      crime_pass_rate: Map.get(data, "crime_pass_rate"),
      checkpoint_pass_rate: Map.get(data, "checkpoint_pass_rate")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
