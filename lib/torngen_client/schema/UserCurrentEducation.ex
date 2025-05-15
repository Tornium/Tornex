defmodule Torngen.Client.Schema.UserCurrentEducation do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :until,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          until: integer(),
          id: Torngen.Client.Schema.EducationId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: Map.get(data, "until"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
