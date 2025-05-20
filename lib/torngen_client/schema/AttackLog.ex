defmodule Torngen.Client.Schema.AttackLog do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :text,
    :icon,
    :defender,
    :attacker,
    :action
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          timestamp: integer(),
          text: String.t(),
          icon: String.t(),
          defender: nil | %{:name => String.t(), :id => Torngen.Client.Schema.UserId.t()},
          attacker:
            nil
            | %{
                :name => String.t(),
                :item => nil | %{:name => String.t(), :id => Torngen.Client.Schema.ItemId.t()},
                :id => Torngen.Client.Schema.UserId.t()
              },
          action: Torngen.Client.Schema.AttackActionEnum.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      text: Map.get(data, "text") |> Torngen.Client.Schema.parse({:static, :string}),
      icon: Map.get(data, "icon") |> Torngen.Client.Schema.parse({:static, :string}),
      defender:
        Map.get(data, "defender")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, object: %{"id" => Torngen.Client.Schema.UserId, "name" => {:static, :string}}]}
        ),
      attacker:
        Map.get(data, "attacker")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             object: %{
               "id" => Torngen.Client.Schema.UserId,
               "item" =>
                 {:one_of,
                  [static: :null, object: %{"id" => Torngen.Client.Schema.ItemId, "name" => {:static, :string}}]},
               "name" => {:static, :string}
             }
           ]}
        ),
      action: Map.get(data, "action") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackActionEnum)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
