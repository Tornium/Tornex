defmodule Torngen.Client.Schema.FactionContributorsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :contributors
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          contributors: [Torngen.Client.Schema.FactionContributor.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      contributors:
        Map.get(data, "contributors") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionContributor})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
