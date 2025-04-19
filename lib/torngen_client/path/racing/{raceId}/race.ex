defmodule Torngen.Client.Path.Racing.RaceId.Race do
  @moduledoc """
  Get specific race details.

  Requires public access key. <br>Returns the details of a race.

  ## Parmeters
  - raceId: Race id

  ## Response
  NYI

  ## Tags
  - Racing
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "racing/{raceId}/race"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :raceId, value do
    # Race id
    {:path, :raceId, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end