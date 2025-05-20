defmodule Torngen.Client.Schema.FactionApplication do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :valid_until,
    :user,
    :status,
    :message,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          valid_until: integer(),
          user: %{
            :stats => %{:strength => integer(), :speed => integer(), :dexterity => integer(), :defense => integer()},
            :name => String.t(),
            :level => integer(),
            :id => Torngen.Client.Schema.UserId.t()
          },
          status: Torngen.Client.Schema.FactionApplicationStatusEnum.t(),
          message: String.t(),
          id: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      valid_until: Map.get(data, "valid_until") |> Torngen.Client.Schema.parse({:static, :integer}),
      user:
        Map.get(data, "user")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "id" => Torngen.Client.Schema.UserId,
             "level" => {:static, :integer},
             "name" => {:static, :string},
             "stats" =>
               {:object,
                %{
                  "defense" => {:static, :integer},
                  "dexterity" => {:static, :integer},
                  "speed" => {:static, :integer},
                  "strength" => {:static, :integer}
                }}
           }}
        ),
      status:
        Map.get(data, "status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionApplicationStatusEnum),
      message: Map.get(data, "message") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
