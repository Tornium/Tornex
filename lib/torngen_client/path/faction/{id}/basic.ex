defmodule Torngen.Client.Path.Faction.Id.Basic do
  @moduledoc """
  Get a faction's basic details.

  Requires public access key. <br> The 'is_enlisted' value will be populated if you're requesting data for your faction and have faction permissions (with custom, limited or full access keys), otherwise it will be set as null.

  ## Parmeters
  - id: Faction id

  ## Tags
  - Faction
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "faction/{id}/basic"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :id, value do
    # Faction id
    {:path, :id, value}
  end

  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end
