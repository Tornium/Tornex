defmodule Torngen.Client.Schema.FactionBalance do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :members,
    :faction
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          members: [
            %{
              :username => String.t(),
              :points => integer(),
              :money => integer(),
              :id => Torngen.Client.Schema.UserId.t()
            }
          ],
          faction: %{:scope => integer(), :points => integer(), :money => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      members: Map.get(data, "members"),
      faction: Map.get(data, "faction")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
