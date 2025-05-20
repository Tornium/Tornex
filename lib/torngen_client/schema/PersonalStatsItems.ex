defmodule Torngen.Client.Schema.PersonalStatsItems do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :items
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          items: %{
            :viruses_coded => integer(),
            :used => %{
              :stat_enhancers => integer(),
              :energy_drinks => integer(),
              :easter_eggs => integer(),
              :consumables => integer(),
              :candy => integer(),
              :boosters => integer(),
              :books => integer(),
              :alcohol => integer()
            },
            :trashed => integer(),
            :found => %{:easter_eggs => integer(), :dump => integer(), :city => integer()}
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      items:
        Map.get(data, "items")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "found" =>
               {:object,
                %{"city" => {:static, :integer}, "dump" => {:static, :integer}, "easter_eggs" => {:static, :integer}}},
             "trashed" => {:static, :integer},
             "used" =>
               {:object,
                %{
                  "alcohol" => {:static, :integer},
                  "books" => {:static, :integer},
                  "boosters" => {:static, :integer},
                  "candy" => {:static, :integer},
                  "consumables" => {:static, :integer},
                  "easter_eggs" => {:static, :integer},
                  "energy_drinks" => {:static, :integer},
                  "stat_enhancers" => {:static, :integer}
                }},
             "viruses_coded" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
