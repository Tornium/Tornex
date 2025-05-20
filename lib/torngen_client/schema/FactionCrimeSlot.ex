defmodule Torngen.Client.Schema.FactionCrimeSlot do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :user,
    :position,
    :item_requirement,
    :checkpoint_pass_rate
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          user: nil | Torngen.Client.Schema.FactionCrimeUser.t(),
          position: String.t(),
          item_requirement:
            nil | %{:is_reusable => boolean(), :is_available => boolean(), :id => Torngen.Client.Schema.ItemId.t()},
          checkpoint_pass_rate: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user:
        Map.get(data, "user")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUser]}),
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
      checkpoint_pass_rate: Map.get(data, "checkpoint_pass_rate") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
