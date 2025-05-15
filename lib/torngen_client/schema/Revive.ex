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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp"),
      target: Map.get(data, "target"),
      success_chance: Map.get(data, "success_chance"),
      reviver: Map.get(data, "reviver"),
      result: Map.get(data, "result"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
