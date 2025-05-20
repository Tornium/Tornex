defmodule Torngen.Client.Schema.FactionApplicationsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :applications
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          applications: [Torngen.Client.Schema.FactionApplication.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      applications:
        Map.get(data, "applications") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionApplication})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
