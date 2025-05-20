defmodule Torngen.Client.Schema.UserCrimeAttempts do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      success: Map.get(data, "success") |> Torngen.Client.Schema.parse({:static, :integer}),
      subcrimes:
        Map.get(data, "subcrimes") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserSubcrime}),
      fail: Map.get(data, "fail") |> Torngen.Client.Schema.parse({:static, :integer}),
      critical_fail: Map.get(data, "critical_fail") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
