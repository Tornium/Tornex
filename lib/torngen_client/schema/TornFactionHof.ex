defmodule Torngen.Client.Schema.TornFactionHof do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :values,
    :rank,
    :position,
    :name,
    :members,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          values: Torngen.Client.Schema.FactionHofValues.t(),
          rank: String.t(),
          position: integer(),
          name: String.t(),
          members: integer(),
          id: Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: Map.get(data, "values") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionHofValues),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse({:static, :string}),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      members: Map.get(data, "members") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
