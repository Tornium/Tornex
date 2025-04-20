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
end
