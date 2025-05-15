defmodule Torngen.Client.Schema.AttackLog do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :text,
    :icon,
    :defender,
    :attacker,
    :action
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          timestamp: integer(),
          text: String.t(),
          icon: String.t(),
          defender: nil | %{:name => String.t(), :id => Torngen.Client.Schema.UserId.t()},
          attacker:
            nil
            | %{
                :name => String.t(),
                :item => nil | %{:name => String.t(), :id => Torngen.Client.Schema.ItemId.t()},
                :id => Torngen.Client.Schema.UserId.t()
              },
          action: Torngen.Client.Schema.AttackActionEnum.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp"),
      text: Map.get(data, "text"),
      icon: Map.get(data, "icon"),
      defender: Map.get(data, "defender"),
      attacker: Map.get(data, "attacker"),
      action: Map.get(data, "action")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
