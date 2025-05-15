defmodule Torngen.Client.Schema.UserPersonalStatsHistoric do
  @moduledoc """
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
      personalstats: Map.get(data, "personalstats")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
