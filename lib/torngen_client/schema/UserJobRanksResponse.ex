defmodule Torngen.Client.Schema.UserJobRanksResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :jobranks
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          jobranks: Torngen.Client.Schema.UserJobRanks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jobranks: Map.get(data, "jobranks") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserJobRanks)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
