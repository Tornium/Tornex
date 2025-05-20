defmodule Torngen.Client.Schema.FactionMembersResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :members
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          members: [Torngen.Client.Schema.FactionMember.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      members: Map.get(data, "members") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionMember})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
