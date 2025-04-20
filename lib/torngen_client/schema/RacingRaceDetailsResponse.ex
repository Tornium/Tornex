defmodule Torngen.Client.Schema.RacingRaceDetailsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  @type t :: [Torngen.Client.Schema.Race.t() | %{:results => [Torngen.Client.Schema.RacerDetails.t()]}]
end
