defmodule Torngen.Client.Schema.TornFactionTreeBranch do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :upgrades,
    :name,
    :id
  ]

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
end
