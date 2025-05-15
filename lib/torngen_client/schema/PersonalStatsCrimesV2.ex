defmodule Torngen.Client.Schema.PersonalStatsCrimesV2 do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :version,
    :skills,
    :offenses
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          version: String.t(),
          skills: %{
            :shoplifting => integer(),
            :search_for_cash => integer(),
            :scamming => integer(),
            :pickpocketing => integer(),
            :hustling => integer(),
            :graffiti => integer(),
            :forgery => integer(),
            :disposal => integer(),
            :cracking => integer(),
            :card_skimming => integer(),
            :burglary => integer(),
            :bootlegging => integer()
          },
          offenses: %{
            :vandalism => integer(),
            :total => integer(),
            :theft => integer(),
            :organized_crimes => integer(),
            :illicit_services => integer(),
            :illegal_production => integer(),
            :fraud => integer(),
            :extortion => integer(),
            :cybercrime => integer(),
            :counterfeiting => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      version: Map.get(data, "version"),
      skills: Map.get(data, "skills"),
      offenses: Map.get(data, "offenses")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
