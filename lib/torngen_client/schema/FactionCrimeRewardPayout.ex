defmodule Torngen.Client.Schema.FactionCrimeRewardPayout do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionOrganizedCrimePayoutType),
      percentage: Map.get(data, "percentage") |> Torngen.Client.Schema.parse({:static, :integer}),
      paid_by: Map.get(data, "paid_by") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      paid_at: Map.get(data, "paid_at") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
