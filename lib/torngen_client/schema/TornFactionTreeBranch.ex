defmodule Torngen.Client.Schema.TornFactionTreeBranch do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      upgrades:
        Map.get(data, "upgrades")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "ability" => {:static, :string},
              "challenge" =>
                {:one_of,
                 [
                   static: :null,
                   object: %{
                     "amount_required" => {:static, :integer},
                     "description" => {:static, :string},
                     "stat" => Torngen.Client.Schema.FactionStatEnum
                   }
                 ]},
              "cost" => {:static, :integer},
              "level" => {:static, :integer},
              "name" => {:static, :string}
            }}}
        ),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBranchId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
