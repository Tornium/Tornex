defmodule Torngen.Client.Path.Faction.Chainreport do
  @moduledoc """
  Get your faction's latest chain report.

  Requires public access key. <br> This includes currently ongoing chains.

  ## Parmeters

  ## Response
  NYI

  ## Tags
  - Faction
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "faction/chainreport"

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