defmodule Torngen.Client.Schema.PersonalStatsBounties do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :bounties
  ]

  @type t :: %__MODULE__{
          bounties: %{
            :received => %{:value => integer(), :amount => integer()},
            :placed => %{:value => integer(), :amount => integer()},
            :collected => %{:value => integer(), :amount => integer()}
          }
        }
end
