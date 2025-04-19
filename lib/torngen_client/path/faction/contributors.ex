defmodule Torngen.Client.Path.Faction.Contributors do
  @moduledoc """
  Get your faction's challenge contributors.

  Requires limiteed access key with faction API access permissions. <br>

  ## Parmeters
  - stat: Get contributors for this field.
  - cat: By default, this selection will return only current faction's member contributions, and the option 'all' will return all contributors.

  ## Response
  NYI

  ## Tags
  - Faction
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "faction/contributors"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :stat, value do
    # Get contributors for this field.
    {:query, :stat, value}
  end
  
  @impl true
  defparameter :cat, value do
    # By default, this selection will return only current faction's member contributions, and the option 'all' will return all contributors.
    {:query, :cat, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end