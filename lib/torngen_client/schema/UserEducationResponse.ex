defmodule Torngen.Client.Schema.UserEducationResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :education
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          education: Torngen.Client.Schema.UserEducation.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      education: Map.get(data, "education")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
