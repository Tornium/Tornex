defmodule Torngen.Client.Schema.RacingCarUpgradesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :carupgrades
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          carupgrades: [Torngen.Client.Schema.RaceCarUpgrade.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      carupgrades:
        Map.get(data, "carupgrades") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceCarUpgrade})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
