defmodule Torngen.Client.Path.Torn.Calendar do
  @moduledoc """
  Get calendar information.

  Requires public access key. <br> Get the details about competitions & events in the running year.

  ## Parmeters

  ## Response
  NYI

  ## Tags
  - Torn
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "torn/calendar"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end