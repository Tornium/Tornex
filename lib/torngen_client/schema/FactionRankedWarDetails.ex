defmodule Torngen.Client.Schema.FactionRankedWarDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :target,
    :start,
    :id,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          target: integer(),
          start: integer(),
          id: Torngen.Client.Schema.RankedWarId.t(),
          factions: [
            %{:score => integer(), :name => String.t(), :id => Torngen.Client.Schema.FactionId.t(), :chain => integer()}
          ],
          end: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner:
        Map.get(data, "winner")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]}),
      target: Map.get(data, "target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RankedWarId),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "chain" => {:static, :integer},
              "id" => Torngen.Client.Schema.FactionId,
              "name" => {:static, :string},
              "score" => {:static, :integer}
            }}}
        ),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
