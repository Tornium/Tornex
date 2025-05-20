defmodule Torngen.Client.Schema.TornEducation do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer}),
      courses:
        Map.get(data, "courses") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornEducationCourses})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
