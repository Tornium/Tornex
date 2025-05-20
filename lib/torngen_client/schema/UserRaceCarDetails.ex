defmodule Torngen.Client.Schema.UserRaceCarDetails do
  @moduledoc """
  [SHORT DESCRIPTION]

  Type: AllOf
  """

  @behaviour Torngen.Client.Schema

  @type t :: [
          Torngen.Client.Schema.RaceCar.t()
          | %{
              :worth => integer(),
              :races_won => integer(),
              :races_entered => integer(),
              :points_spent => integer(),
              :parts => [Torngen.Client.Schema.RaceCarUpgradeId.t()],
              :name => nil | String.t(),
              :is_removed => boolean(),
              :id => Torngen.Client.Schema.RaceCarId.t()
            }
        ]
end
