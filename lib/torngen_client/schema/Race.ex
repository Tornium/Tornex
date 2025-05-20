defmodule Torngen.Client.Schema.Race do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

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
end
