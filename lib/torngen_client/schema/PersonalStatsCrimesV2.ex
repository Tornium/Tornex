defmodule Torngen.Client.Schema.PersonalStatsCrimesV2 do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      version: Map.get(data, "version") |> Torngen.Client.Schema.parse({:static, :string}),
      skills:
        Map.get(data, "skills")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "bootlegging" => {:static, :integer},
             "burglary" => {:static, :integer},
             "card_skimming" => {:static, :integer},
             "cracking" => {:static, :integer},
             "disposal" => {:static, :integer},
             "forgery" => {:static, :integer},
             "graffiti" => {:static, :integer},
             "hustling" => {:static, :integer},
             "pickpocketing" => {:static, :integer},
             "scamming" => {:static, :integer},
             "search_for_cash" => {:static, :integer},
             "shoplifting" => {:static, :integer}
           }}
        ),
      offenses:
        Map.get(data, "offenses")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "counterfeiting" => {:static, :integer},
             "cybercrime" => {:static, :integer},
             "extortion" => {:static, :integer},
             "fraud" => {:static, :integer},
             "illegal_production" => {:static, :integer},
             "illicit_services" => {:static, :integer},
             "organized_crimes" => {:static, :integer},
             "theft" => {:static, :integer},
             "total" => {:static, :integer},
             "vandalism" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
