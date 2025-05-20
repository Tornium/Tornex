defmodule Torngen.Client.Schema.PersonalStatsItemsPopular do
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
            :found => %{:dump => integer()}
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
             "found" => {:object, %{"dump" => {:static, :integer}}},
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
                }}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
