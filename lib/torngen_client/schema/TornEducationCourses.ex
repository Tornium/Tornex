defmodule Torngen.Client.Schema.TornEducationCourses do
  @moduledoc """
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
      rewards: Map.get(data, "rewards"),
      prerequisites: Map.get(data, "prerequisites"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      duration: Map.get(data, "duration"),
      description: Map.get(data, "description"),
      code: Map.get(data, "code")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
