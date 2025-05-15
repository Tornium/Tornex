defmodule Torngen.Client.Schema.TornFactionTreeBranch do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :upgrades,
    :name,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          upgrades: [
            %{
              :name => String.t(),
              :level => integer(),
              :cost => integer(),
              :challenge =>
                nil
                | %{
                    :stat => Torngen.Client.Schema.FactionStatEnum.t(),
                    :description => String.t(),
                    :amount_required => integer()
                  },
              :ability => String.t()
            }
          ],
          name: String.t(),
          id: Torngen.Client.Schema.FactionBranchId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      upgrades: Map.get(data, "upgrades"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
