defmodule Torngen.Client.Schema.Race do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:track_id, :title, :status, :schedule, :requirements, :participants, :laps, :id, :creator_id]

  defstruct [
    :track_id,
    :title,
    :status,
    :schedule,
    :requirements,
    :participants,
    :laps,
    :id,
    :creator_id
  ]

  @type t :: %__MODULE__{
          track_id: Torngen.Client.Schema.RaceTrackId.t(),
          title: String.t(),
          status: Torngen.Client.Schema.RaceStatusEnum.t(),
          schedule: %{:start => integer(), :join_until => integer(), :join_from => integer(), :end => nil | integer()},
          requirements: %{
            :requires_stock_car => boolean(),
            :requires_password => boolean(),
            :join_fee => integer(),
            :driver_class => nil | Torngen.Client.Schema.RaceClassEnum.t(),
            :car_item_id => nil | Torngen.Client.Schema.ItemId.t(),
            :car_class => nil | Torngen.Client.Schema.RaceClassEnum.t()
          },
          participants: %{:minimum => integer(), :maximum => integer(), :current => integer()},
          laps: integer(),
          id: Torngen.Client.Schema.RaceId.t(),
          creator_id: Torngen.Client.Schema.UserId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      track_id: Map.get(data, "track_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceTrackId),
      title: Map.get(data, "title") |> Torngen.Client.Schema.parse({:static, :string}),
      status: Map.get(data, "status") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceStatusEnum),
      schedule:
        Map.get(data, "schedule")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "end" => {:one_of, [static: :null, static: :integer]},
             "join_from" => {:static, :integer},
             "join_until" => {:static, :integer},
             "start" => {:static, :integer}
           }}
        ),
      requirements:
        Map.get(data, "requirements")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "car_class" => {:one_of, [{:static, :null}, Torngen.Client.Schema.RaceClassEnum]},
             "car_item_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.ItemId]},
             "driver_class" => {:one_of, [{:static, :null}, Torngen.Client.Schema.RaceClassEnum]},
             "join_fee" => {:static, :integer},
             "requires_password" => {:static, :boolean},
             "requires_stock_car" => {:static, :boolean}
           }}
        ),
      participants:
        Map.get(data, "participants")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{"current" => {:static, :integer}, "maximum" => {:static, :integer}, "minimum" => {:static, :integer}}}
        ),
      laps: Map.get(data, "laps") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaceId),
      creator_id: Map.get(data, "creator_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId)
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:track_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceTrackId)
  end

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:status, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceStatusEnum)
  end

  defp validate_key?(:schedule, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "end" => {:one_of, [static: :null, static: :integer]},
         "join_from" => {:static, :integer},
         "join_until" => {:static, :integer},
         "start" => {:static, :integer}
       }}
    )
  end

  defp validate_key?(:requirements, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "car_class" => {:one_of, [{:static, :null}, Torngen.Client.Schema.RaceClassEnum]},
         "car_item_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.ItemId]},
         "driver_class" => {:one_of, [{:static, :null}, Torngen.Client.Schema.RaceClassEnum]},
         "join_fee" => {:static, :integer},
         "requires_password" => {:static, :boolean},
         "requires_stock_car" => {:static, :boolean}
       }}
    )
  end

  defp validate_key?(:participants, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"current" => {:static, :integer}, "maximum" => {:static, :integer}, "minimum" => {:static, :integer}}}
    )
  end

  defp validate_key?(:laps, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaceId)
  end

  defp validate_key?(:creator_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
