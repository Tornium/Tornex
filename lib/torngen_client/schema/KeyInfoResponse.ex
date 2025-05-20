defmodule Torngen.Client.Schema.KeyInfoResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :info
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          info: %{
            :selections => %{
              :user => [Torngen.Client.Schema.UserSelectionName.t()],
              :torn => [Torngen.Client.Schema.TornSelectionName.t()],
              :racing => [Torngen.Client.Schema.RacingSelectionName.t()],
              :property => [String.t()],
              :market => [Torngen.Client.Schema.MarketSelectionName.t()],
              :key => [Torngen.Client.Schema.KeySelectionName.t()],
              :forum => [Torngen.Client.Schema.ForumSelectionName.t()],
              :faction => [Torngen.Client.Schema.FactionSelectionName.t()],
              :company => [String.t()]
            },
            :access => %{
              :type => Torngen.Client.Schema.ApiKeyAccessTypeEnum.t(),
              :level => integer(),
              :faction => boolean(),
              :company => boolean()
            }
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      info:
        Map.get(data, "info")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "access" =>
               {:object,
                %{
                  "company" => {:static, :boolean},
                  "faction" => {:static, :boolean},
                  "level" => {:static, :integer},
                  "type" => Torngen.Client.Schema.ApiKeyAccessTypeEnum
                }},
             "selections" =>
               {:object,
                %{
                  "company" => {:array, {:static, :string}},
                  "faction" => {:array, Torngen.Client.Schema.FactionSelectionName},
                  "forum" => {:array, Torngen.Client.Schema.ForumSelectionName},
                  "key" => {:array, Torngen.Client.Schema.KeySelectionName},
                  "market" => {:array, Torngen.Client.Schema.MarketSelectionName},
                  "property" => {:array, {:static, :string}},
                  "racing" => {:array, Torngen.Client.Schema.RacingSelectionName},
                  "torn" => {:array, Torngen.Client.Schema.TornSelectionName},
                  "user" => {:array, Torngen.Client.Schema.UserSelectionName}
                }}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
