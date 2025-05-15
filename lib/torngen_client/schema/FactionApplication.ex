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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          valid_until: integer(),
          user: %{
            :stats => %{:strength => integer(), :speed => integer(), :dexterity => integer(), :defense => integer()},
            :name => String.t(),
            :level => integer(),
            :id => Torngen.Client.Schema.UserId.t()
          },
          status: Torngen.Client.Schema.FactionApplicationStatusEnum.t(),
          message: String.t(),
          id: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      valid_until: Map.get(data, "valid_until"),
      user: Map.get(data, "user"),
      status: Map.get(data, "status"),
      message: Map.get(data, "message"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
