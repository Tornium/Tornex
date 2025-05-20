defmodule Torngen.Client.Schema.FactionCrimeSlot do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :user_id,
    :user,
    :success_chance,
    :position,
    :item_requirement,
    :crime_pass_rate,
    :checkpoint_pass_rate
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          user_id: nil | Torngen.Client.Schema.UserId.t(),
          user: nil | Torngen.Client.Schema.FactionCrimeUser.t(),
          success_chance: integer(),
          position: String.t(),
          item_requirement:
            nil | %{:is_reusable => boolean(), :is_available => boolean(), :id => Torngen.Client.Schema.ItemId.t()},
          crime_pass_rate: integer(),
          checkpoint_pass_rate: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user_id:
        Map.get(data, "user_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      user:
        Map.get(data, "user")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUser]}),
      success_chance: Map.get(data, "success_chance") |> Torngen.Client.Schema.parse({:static, :integer}),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:static, :string}),
      item_requirement:
        Map.get(data, "item_requirement")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             object: %{
               "id" => Torngen.Client.Schema.ItemId,
               "is_available" => {:static, :boolean},
               "is_reusable" => {:static, :boolean}
             }
           ]}
        ),
      crime_pass_rate: Map.get(data, "crime_pass_rate") |> Torngen.Client.Schema.parse({:static, :integer}),
      checkpoint_pass_rate: Map.get(data, "checkpoint_pass_rate") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
