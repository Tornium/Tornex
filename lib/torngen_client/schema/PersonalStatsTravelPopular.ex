defmodule Torngen.Client.Schema.PersonalStatsTravelPopular do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :travel
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          travel: %{:total => integer(), :time_spent => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      travel:
        Map.get(data, "travel")
        |> Torngen.Client.Schema.parse(
          {:object, %{"time_spent" => {:static, :integer}, "total" => {:static, :integer}}}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
