defmodule Torngen.Client.Schema.TornEducation do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :id,
    :courses
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          name: String.t(),
          id: integer(),
          courses: [Torngen.Client.Schema.TornEducationCourses.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      courses: Map.get(data, "courses")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
