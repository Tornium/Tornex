defmodule Torngen.Client.Path.Torn.Itemmods do
  @moduledoc """
  Get information about weapon upgrades.

  Requires public key.

  ## Parmeters

  ## Response
  NYI

  ## Tags
  - Torn
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "torn/itemmods"

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