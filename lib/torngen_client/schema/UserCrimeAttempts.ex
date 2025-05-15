defmodule Torngen.Client.Schema.UserCrimeAttempts do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :success,
    :subcrimes,
    :fail,
    :critical_fail
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          total: integer(),
          success: integer(),
          subcrimes: [Torngen.Client.Schema.UserSubcrime.t()],
          fail: integer(),
          critical_fail: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: Map.get(data, "total"),
      success: Map.get(data, "success"),
      subcrimes: Map.get(data, "subcrimes"),
      fail: Map.get(data, "fail"),
      critical_fail: Map.get(data, "critical_fail")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
