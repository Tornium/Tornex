defmodule Torngen.Client.Schema.TornCrime do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :unique_outcomes_ids,
    :unique_outcomes_count,
    :notes,
    :name,
    :id,
    :enhancer_name,
    :enhancer_id,
    :category_name,
    :category_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          unique_outcomes_ids: [integer()],
          unique_outcomes_count: integer(),
          notes: [String.t()],
          name: String.t(),
          id: Torngen.Client.Schema.TornCrimeId.t(),
          enhancer_name: String.t(),
          enhancer_id: integer(),
          category_name: String.t(),
          category_id: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      unique_outcomes_ids:
        Map.get(data, "unique_outcomes_ids") |> Torngen.Client.Schema.parse({:array, {:static, :integer}}),
      unique_outcomes_count: Map.get(data, "unique_outcomes_count") |> Torngen.Client.Schema.parse({:static, :integer}),
      notes: Map.get(data, "notes") |> Torngen.Client.Schema.parse({:array, {:static, :string}}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornCrimeId),
      enhancer_name: Map.get(data, "enhancer_name") |> Torngen.Client.Schema.parse({:static, :string}),
      enhancer_id: Map.get(data, "enhancer_id") |> Torngen.Client.Schema.parse({:static, :integer}),
      category_name: Map.get(data, "category_name") |> Torngen.Client.Schema.parse({:static, :string}),
      category_id: Map.get(data, "category_id") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
