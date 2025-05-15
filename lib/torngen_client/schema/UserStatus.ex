defmodule Torngen.Client.Schema.UserStatus do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :until,
    :state,
    :details,
    :description
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          until: nil | integer(),
          state: String.t(),
          details: nil | String.t(),
          description: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: Map.get(data, "until"),
      state: Map.get(data, "state"),
      details: Map.get(data, "details"),
      description: Map.get(data, "description")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
