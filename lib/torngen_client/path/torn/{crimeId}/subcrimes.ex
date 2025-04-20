defmodule Torngen.Client.Path.Torn.CrimeId.Subcrimes do
  @moduledoc """
  Get Subcrimes information.

  Requires public access key. <br> Return the details about possible actions for a specific crime.

  ## Parmeters
  - crimeId: Crime id

  ## Tags
  - Torn
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn/{crimeId}/subcrimes"

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
