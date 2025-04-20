defmodule Torngen.Client.Path.Racing.TrackId.Records do
  @moduledoc """
  Get track records.

  Requires public access key. <br>Returns a list of 10 best lap records for the chosen track and car class. Results are cached globally 1 hour.

  ## Parmeters
  - trackId: Track id
  - cat: Car class

  ## Response
  NYI

  ## Tags
  - Racing
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "racing/{trackId}/records"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :trackId, value do
    # Track id
    {:path, :trackId, value}
  end
  
  @impl true
  defparameter :cat, value do
    # Car class
    {:query, :cat, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end