defmodule Torngen.Client.Schema.UserCrimeDetailsGraffiti do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :most_graffiti_simultaneously,
    :most_graffiti_in_one_area,
    :graffiti_removed,
    :cost_to_city,
    :cans_used
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          most_graffiti_simultaneously: integer(),
          most_graffiti_in_one_area: integer(),
          graffiti_removed: integer(),
          cost_to_city: integer(),
          cans_used: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      most_graffiti_simultaneously:
        Map.get(data, "most_graffiti_simultaneously") |> Torngen.Client.Schema.parse({:static, :integer}),
      most_graffiti_in_one_area:
        Map.get(data, "most_graffiti_in_one_area") |> Torngen.Client.Schema.parse({:static, :integer}),
      graffiti_removed: Map.get(data, "graffiti_removed") |> Torngen.Client.Schema.parse({:static, :integer}),
      cost_to_city: Map.get(data, "cost_to_city") |> Torngen.Client.Schema.parse({:static, :integer}),
      cans_used: Map.get(data, "cans_used") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
