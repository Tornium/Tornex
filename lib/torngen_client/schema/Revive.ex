defmodule Torngen.Client.Schema.Revive do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :target,
    :success_chance,
    :reviver,
    :result,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          timestamp: integer(),
          target: %{
            :online_status => String.t(),
            :name => String.t(),
            :last_action => integer(),
            :id => Torngen.Client.Schema.UserId.t(),
            :hospital_reason => String.t(),
            :faction => nil | %{:name => String.t(), :id => Torngen.Client.Schema.FactionId.t()},
            :early_discharge => boolean()
          },
          success_chance: integer() | float(),
          reviver: %{
            :name => String.t(),
            :id => Torngen.Client.Schema.UserId.t(),
            :faction => nil | %{:name => String.t(), :id => Torngen.Client.Schema.FactionId.t()}
          },
          result: String.t(),
          id: Torngen.Client.Schema.ReviveId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      target:
        Map.get(data, "target")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "early_discharge" => {:static, :boolean},
             "faction" =>
               {:one_of,
                [static: :null, object: %{"id" => Torngen.Client.Schema.FactionId, "name" => {:static, :string}}]},
             "hospital_reason" => {:static, :string},
             "id" => Torngen.Client.Schema.UserId,
             "last_action" => {:static, :integer},
             "name" => {:static, :string},
             "online_status" => {:static, :string}
           }}
        ),
      success_chance: Map.get(data, "success_chance") |> Torngen.Client.Schema.parse({:static, :number}),
      reviver:
        Map.get(data, "reviver")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "faction" =>
               {:one_of,
                [static: :null, object: %{"id" => Torngen.Client.Schema.FactionId, "name" => {:static, :string}}]},
             "id" => Torngen.Client.Schema.UserId,
             "name" => {:static, :string}
           }}
        ),
      result: Map.get(data, "result") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReviveId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
