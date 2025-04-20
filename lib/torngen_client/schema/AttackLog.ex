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
end
