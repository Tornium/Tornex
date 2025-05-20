defmodule Torngen.Client.Schema.RacingRaceDetailsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :race
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          race: [Torngen.Client.Schema.Race.t() | %{:results => [Torngen.Client.Schema.RacerDetails.t()]}]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      race:
        Map.get(data, "race")
        |> Torngen.Client.Schema.parse(
          {:all_of,
           [Torngen.Client.Schema.Race, {:object, %{"results" => {:array, Torngen.Client.Schema.RacerDetails}}}]}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
