defmodule Torngen.Client.Path.Torn.LogCategoryId.Logtypes do
  @moduledoc """
  Get available log ids for a specific log category.

  Requires public key. <br>

  ## Parmeters
  - logCategoryId: Log category id

  ## Tags
  - Torn
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn/{logCategoryId}/logtypes"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :logCategoryId, value do
    # Log category id
    {:path, :logCategoryId, value}
  end

  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end
