defmodule Torngen.Client.Path.Market.Id.Itemmarket do
  @moduledoc """
  Get item market listings.

  Requires public access key. <br>

  ## Parmeters
  - id: Item id
  - bonus: Used to filter weapons with a specific bonus.
  - offset: N/A

  ## Response
  NYI

  ## Tags
  - Market
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "market/{id}/itemmarket"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :id, value do
    # Item id
    {:path, :id, value}
  end
  
  @impl true
  defparameter :bonus, value do
    # Used to filter weapons with a specific bonus.
    {:query, :bonus, value}
  end
  
  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end