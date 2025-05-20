defmodule Torngen.Client.Schema.UserList do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :status,
    :name,
    :level,
    :last_action,
    :id,
    :faction_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserStatus.t(),
          name: String.t(),
          level: integer(),
          last_action: Torngen.Client.Schema.UserLastAction.t(),
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status: Map.get(data, "status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserStatus),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_action: Map.get(data, "last_action") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserLastAction),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      faction_id:
        Map.get(data, "faction_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
