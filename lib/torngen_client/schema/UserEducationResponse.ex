defmodule Torngen.Client.Schema.UserEducationResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      education: Map.get(data, "education") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserEducation)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
