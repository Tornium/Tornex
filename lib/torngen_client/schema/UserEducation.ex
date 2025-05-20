defmodule Torngen.Client.Schema.UserEducation do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      current:
        Map.get(data, "current")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserCurrentEducation]}),
      complete: Map.get(data, "complete") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.EducationId})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
