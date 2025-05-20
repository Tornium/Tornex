defmodule Torngen.Client.Schema.UserPersonalStatsHistoric do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :personalstats
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          personalstats: [Torngen.Client.Schema.PersonalStatsHistoricStat.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      personalstats:
        Map.get(data, "personalstats")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.PersonalStatsHistoricStat})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
