defmodule Torngen.Client.Schema.RacingTrackRecordsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :records
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          records: [Torngen.Client.Schema.RaceRecord.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      records: Map.get(data, "records") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceRecord})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
