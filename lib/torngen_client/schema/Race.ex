defmodule Torngen.Client.Schema.Race do
  @moduledoc """
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
      track_id: Map.get(data, "track_id"),
      title: Map.get(data, "title"),
      status: Map.get(data, "status"),
      schedule: Map.get(data, "schedule"),
      requirements: Map.get(data, "requirements"),
      participants: Map.get(data, "participants"),
      laps: Map.get(data, "laps"),
      id: Map.get(data, "id"),
      creator_id: Map.get(data, "creator_id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
