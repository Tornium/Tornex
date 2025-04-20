defmodule Torngen.Client.Schema.ReviveSimplified do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :target,
    :success_chance,
    :reviver,
    :result,
    :id
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          target: %{
            :online_status => String.t(),
            :last_action => integer(),
            :id => Torngen.Client.Schema.UserId.t(),
            :hospital_reason => String.t(),
            :faction_id => nil | Torngen.Client.Schema.FactionId.t(),
            :early_discharge => boolean()
          },
          success_chance: integer() | float(),
          reviver: %{:id => Torngen.Client.Schema.UserId.t(), :faction_id => nil | Torngen.Client.Schema.FactionId.t()},
          result: String.t(),
          id: Torngen.Client.Schema.ReviveId.t()
        }
end
