defmodule Torngen.Client.Path.User.Id.Personalstats do
  @moduledoc """
  Get a player's personal stats.

  Requires public access key. <br>
 *  UserPersonalStatsFull is returned only when this selection is requested for the key owner with Limited, Full or Custom key.
 *  UserPersonalStatsFullPublic is returned when the requested category is 'all'.
 *  UserPersonalStatsPopular is returned when the requested category is 'popular'. Please try to use UserPersonalStatsPopular over UserPersonalStatsFullPublic wherever possible in order to reduce the server load.
 *  Otherwise, UserPersonalStatsCategory is returned for the matched category.
 *  It's possible to request specific stats via 'stat' parameter. In this case the response will vary depending on the stats requested. Private stats are still available only to the key owner (with Limited or higher key).
 *  Additionally, historical stats can also be fetched via 'stat' query parameter, but 'timestamp' parameter must be provided as well. It's only possible to pass up to 10 historical stats at once (the rest is trimmed). When requesting historical stats the response will be of type UserPersonalStatsHistoric.

  ## Parmeters
  - id: User id
  - cat:
  - stat: Stat names (10 maximum)
  - timestamp: Returns stats until this timestamp (converted to nearest date).

  ## Response
  NYI

  ## Tags
  - User
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "user/{id}/personalstats"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :id, value do
    # User id
    {:path, :id, value}
  end
  
  @impl true
  defparameter :cat, value do
    # 
    {:query, :cat, value}
  end
  
  @impl true
  defparameter :stat, value do
    # Stat names (10 maximum). Used to fetch historical stat values
    {:query, :stat, value}
  end
  
  @impl true
  defparameter :timestamp, value do
    # Returns stats until this timestamp (converted to nearest date).
    {:query, :timestamp, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end