defmodule Torngen.Client.Schema.PersonalStatsFinishingHits do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      finishing_hits:
        Map.get(data, "finishing_hits")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "clubbing" => {:static, :integer},
             "hand_to_hand" => {:static, :integer},
             "heavy_artillery" => {:static, :integer},
             "machine_guns" => {:static, :integer},
             "mechanical" => {:static, :integer},
             "piercing" => {:static, :integer},
             "pistols" => {:static, :integer},
             "rifles" => {:static, :integer},
             "shotguns" => {:static, :integer},
             "slashing" => {:static, :integer},
             "sub_machine_guns" => {:static, :integer},
             "temporary" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
