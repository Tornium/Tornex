defmodule Torngen.Client.Schema.PersonalStatsCrimesPopular do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crimes
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          crimes: %{:version => String.t(), :total => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crimes:
        Map.get(data, "crimes")
        |> Torngen.Client.Schema.parse({:object, %{"total" => {:static, :integer}, "version" => {:static, :string}}})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
