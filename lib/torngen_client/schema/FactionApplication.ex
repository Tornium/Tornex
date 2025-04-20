defmodule Torngen.Client.Schema.FactionApplication do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :valid_until,
    :user,
    :status,
    :message,
    :id
  ]

  @type t :: %__MODULE__{
          valid_until: integer(),
          user: %{
            :stats => %{:strength => integer(), :speed => integer(), :dexterity => integer(), :defense => integer()},
            :name => String.t(),
            :level => String.t(),
            :id => Torngen.Client.Schema.UserId.t()
          },
          status: Torngen.Client.Schema.FactionApplicationStatusEnum.t(),
          message: String.t(),
          id: integer()
        }
end
