defmodule Torngen.Client.Schema.UserEducation do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :current,
    :complete
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          current: nil | Torngen.Client.Schema.UserCurrentEducation.t(),
          complete: [Torngen.Client.Schema.EducationId.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      current: Map.get(data, "current"),
      complete: Map.get(data, "complete")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
