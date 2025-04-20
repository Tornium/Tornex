defmodule Torngen.Client.Schema.PersonalStatsJail do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :jail
  ]

  @type t :: %__MODULE__{
          jail: %{
            :times_jailed => integer(),
            :busts => %{:success => integer(), :fails => integer()},
            :bails => %{:fees => integer(), :amount => integer()}
          }
        }
end
