defmodule Torngen.Client.Schema.Revive do
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
            :name => String.t(),
            :last_action => integer(),
            :id => Torngen.Client.Schema.UserId.t(),
            :hospital_reason => String.t(),
            :faction => nil | %{:name => String.t(), :id => Torngen.Client.Schema.FactionId.t()},
            :early_discharge => boolean()
          },
          success_chance: integer() | float(),
          reviver: %{
            :name => String.t(),
            :id => Torngen.Client.Schema.UserId.t(),
            :faction => nil | %{:name => String.t(), :id => Torngen.Client.Schema.FactionId.t()}
          },
          result: String.t(),
          id: Torngen.Client.Schema.ReviveId.t()
        }
end
