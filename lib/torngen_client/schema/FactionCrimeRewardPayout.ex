defmodule Torngen.Client.Schema.FactionCrimeRewardPayout do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :type,
    :percentage,
    :paid_by,
    :paid_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.FactionOrganizedCrimePayoutType.t(),
          percentage: integer(),
          paid_by: Torngen.Client.Schema.UserId.t(),
          paid_at: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type"),
      percentage: Map.get(data, "percentage"),
      paid_by: Map.get(data, "paid_by"),
      paid_at: Map.get(data, "paid_at")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
