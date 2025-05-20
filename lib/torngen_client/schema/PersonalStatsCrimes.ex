defmodule Torngen.Client.Schema.PersonalStatsCrimes do
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
          crimes: Torngen.Client.Schema.PersonalStatsCrimesV2.t() | Torngen.Client.Schema.PersonalStatsCrimesV1.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crimes:
        Map.get(data, "crimes")
        |> Torngen.Client.Schema.parse(
          {:one_of, [Torngen.Client.Schema.PersonalStatsCrimesV2, Torngen.Client.Schema.PersonalStatsCrimesV1]}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
