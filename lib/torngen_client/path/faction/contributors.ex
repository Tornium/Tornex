defmodule Torngen.Client.Path.Faction.Contributors do
  @moduledoc """
  Get your faction's challenge contributors.

  Requires limiteed access key with faction API access permissions. <br>

  ## Parmeters
  - stat: Get contributors for this field.
  - cat: By default, this selection will return only current faction's member contributions, and the option 'all' will return all contributors.
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public)

  ## Response Module(s)
  - FactionContributorsResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "faction/contributors"
  @response_modules [FactionContributorsResponse]

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
  defparameter :timestamp, value do
    # Timestamp to bypass cache
    {:query, :timestamp, value}
  end

  @impl true
  defparameter :comment, value do
    # Comment for your tool/service/bot/website to be visible in the logs.
    {:query, :comment, value}
  end

  @impl true
  defparameter :key, value do
    # API key (Public). It's not required to use this parameter when passing the API key via the Authorization header.
    {:query, :key, value}
  end

  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys

  @impl true
  def parse(response), do: Torngen.Client.Path.parse(@response_modules, response)
end
