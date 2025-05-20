defmodule Torngen.Client.Schema.TornEducationPrerequisites do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :courses,
    :cost
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          courses: [integer()],
          cost: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      courses: Map.get(data, "courses") |> Torngen.Client.Schema.parse({:array, {:static, :integer}}),
      cost: Map.get(data, "cost") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
