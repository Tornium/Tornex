defmodule Torngen.Client.Schema.TornRacket do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :reward,
    :name,
    :level,
    :description,
    :created_at,
    :changed_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          reward: Torngen.Client.Schema.TornRacketReward.t(),
          name: String.t(),
          level: integer(),
          description: String.t(),
          created_at: integer(),
          changed_at: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      reward: Map.get(data, "reward") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornRacketReward),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string}),
      created_at: Map.get(data, "created_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      changed_at: Map.get(data, "changed_at") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
