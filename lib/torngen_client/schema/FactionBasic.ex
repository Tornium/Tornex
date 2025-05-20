defmodule Torngen.Client.Schema.FactionBasic do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :tag_image,
    :tag,
    :respect,
    :rank,
    :name,
    :members,
    :leader_id,
    :is_enlisted,
    :id,
    :days_old,
    :co_leader_id,
    :"co-leader_id",
    :capacity,
    :best_chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          tag_image: String.t(),
          tag: String.t(),
          respect: integer(),
          rank: Torngen.Client.Schema.FactionRank.t(),
          name: String.t(),
          members: integer(),
          leader_id: Torngen.Client.Schema.UserId.t(),
          is_enlisted: nil | boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          days_old: integer(),
          co_leader_id: Torngen.Client.Schema.UserId.t(),
          "co-leader_id": Torngen.Client.Schema.UserId.t(),
          capacity: integer(),
          best_chain: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tag_image: Map.get(data, "tag_image") |> Torngen.Client.Schema.parse({:static, :string}),
      tag: Map.get(data, "tag") |> Torngen.Client.Schema.parse({:static, :string}),
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionRank),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      members: Map.get(data, "members") |> Torngen.Client.Schema.parse({:static, :integer}),
      leader_id: Map.get(data, "leader_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      is_enlisted:
        Map.get(data, "is_enlisted") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :boolean]}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      days_old: Map.get(data, "days_old") |> Torngen.Client.Schema.parse({:static, :integer}),
      co_leader_id: Map.get(data, "co_leader_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      capacity: Map.get(data, "capacity") |> Torngen.Client.Schema.parse({:static, :integer}),
      best_chain: Map.get(data, "best_chain") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
