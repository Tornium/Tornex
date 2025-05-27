defmodule Torngen.Client.Schema.ReportAnonymousBounties do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:bounties]

  defstruct [
    :bounties
  ]

  @type t :: %__MODULE__{
          bounties: [
            %{
              :user => nil | %{:name => String.t(), :id => Torngen.Client.Schema.UserId.t()},
              :text => String.t(),
              :bounty => integer()
            }
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bounties:
        data
        |> Map.get("bounties")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "bounty" => {:static, :integer},
              "text" => {:static, :string},
              "user" =>
                {:one_of,
                 [static: :null, object: %{"id" => Torngen.Client.Schema.UserId, "name" => {:static, :string}}]}
            }}}
        )
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:bounties, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          "bounty" => {:static, :integer},
          "text" => {:static, :string},
          "user" =>
            {:one_of, [static: :null, object: %{"id" => Torngen.Client.Schema.UserId, "name" => {:static, :string}}]}
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
