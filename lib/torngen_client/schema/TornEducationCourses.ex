defmodule Torngen.Client.Schema.TornEducationCourses do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :rewards,
    :prerequisites,
    :name,
    :id,
    :duration,
    :description,
    :code
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          rewards: Torngen.Client.Schema.TornEducationRewards.t(),
          prerequisites: Torngen.Client.Schema.TornEducationPrerequisites.t(),
          name: String.t(),
          id: Torngen.Client.Schema.EducationId.t(),
          duration: integer(),
          description: String.t(),
          code: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rewards: Map.get(data, "rewards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornEducationRewards),
      prerequisites:
        Map.get(data, "prerequisites") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornEducationPrerequisites),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.EducationId),
      duration: Map.get(data, "duration") |> Torngen.Client.Schema.parse({:static, :integer}),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string}),
      code: Map.get(data, "code") |> Torngen.Client.Schema.parse({:static, :string})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
