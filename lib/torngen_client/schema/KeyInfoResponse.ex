defmodule Torngen.Client.Schema.KeyInfoResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:info]

  defstruct [
    :info
  ]

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
              :faction_id => nil | Torngen.Client.Schema.FactionId.t(),
              :faction => boolean(),
              :company_id => nil | Torngen.Client.Schema.CompanyId.t(),
              :company => boolean()
            }
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      info:
        data
        |> Map.get("info")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "access" =>
               {:object,
                %{
                  "company" => {:static, :boolean},
                  "company_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.CompanyId]},
                  "faction" => {:static, :boolean},
                  "faction_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
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
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:info, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "access" =>
           {:object,
            %{
              "company" => {:static, :boolean},
              "company_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.CompanyId]},
              "faction" => {:static, :boolean},
              "faction_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
