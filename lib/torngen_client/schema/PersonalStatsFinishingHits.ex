defmodule Torngen.Client.Schema.PersonalStatsFinishingHits do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :finishing_hits
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          finishing_hits: %{
            :temporary => integer(),
            :sub_machine_guns => integer(),
            :slashing => integer(),
            :shotguns => integer(),
            :rifles => integer(),
            :pistols => integer(),
            :piercing => integer(),
            :mechanical => integer(),
            :machine_guns => integer(),
            :heavy_artillery => integer(),
            :hand_to_hand => integer(),
            :clubbing => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      finishing_hits: Map.get(data, "finishing_hits")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
