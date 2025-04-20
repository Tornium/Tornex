defmodule Torngen.Client.Schema.PersonalStatsCrimesV2 do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :version,
    :skills,
    :offenses
  ]

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
end
