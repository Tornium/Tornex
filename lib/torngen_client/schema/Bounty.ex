defmodule Torngen.Client.Schema.Bounty do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :valid_until,
    :target_name,
    :target_level,
    :target_id,
    :reward,
    :reason,
    :quantity,
    :lister_name,
    :lister_id,
    :is_anonymous
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          valid_until: integer(),
          target_name: String.t(),
          target_level: integer(),
          target_id: Torngen.Client.Schema.UserId.t(),
          reward: integer(),
          reason: nil | String.t(),
          quantity: integer(),
          lister_name: nil | String.t(),
          lister_id: nil | Torngen.Client.Schema.UserId.t(),
          is_anonymous: boolean()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      valid_until: Map.get(data, "valid_until") |> Torngen.Client.Schema.parse({:static, :integer}),
      target_name: Map.get(data, "target_name") |> Torngen.Client.Schema.parse({:static, :string}),
      target_level: Map.get(data, "target_level") |> Torngen.Client.Schema.parse({:static, :integer}),
      target_id: Map.get(data, "target_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      reward: Map.get(data, "reward") |> Torngen.Client.Schema.parse({:static, :integer}),
      reason: Map.get(data, "reason") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      quantity: Map.get(data, "quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      lister_name:
        Map.get(data, "lister_name") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      lister_id:
        Map.get(data, "lister_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      is_anonymous: Map.get(data, "is_anonymous") |> Torngen.Client.Schema.parse({:static, :boolean})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
