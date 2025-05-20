defmodule Torngen.Client.Schema.FactionBalance do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      members:
        Map.get(data, "members")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "id" => Torngen.Client.Schema.UserId,
              "money" => {:static, :integer},
              "points" => {:static, :integer},
              "username" => {:static, :string}
            }}}
        ),
      faction:
        Map.get(data, "faction")
        |> Torngen.Client.Schema.parse(
          {:object, %{"money" => {:static, :integer}, "points" => {:static, :integer}, "scope" => {:static, :integer}}}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
