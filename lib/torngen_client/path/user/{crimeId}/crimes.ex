defmodule Torngen.Client.Path.User.CrimeId.Crimes do
  @moduledoc """
  Get your crime statistics.

  Requires minimal access key. <br>Return the details and statistics about for a specific crime.

  ## Parmeters
  - crimeId: Crime id

  ## Response
  NYI

  ## Tags
  - User
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/{crimeId}/crimes"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :crimeId, value do
    # Crime id
    {:path, :crimeId, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end