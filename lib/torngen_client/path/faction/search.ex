defmodule Torngen.Client.Path.Faction.Search do
  @moduledoc """
  Search factions by name or other criteria.

  Requires public access key. <br>This selection is standalone and cannot be used together with other selections.

  ## Parmeters
  - name: Name  to search for.
  - filters: A filtering query parameter allowing a comma-separated list of filters
  - limit: N/A
  - offset: N/A
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public)

  ## Response Module(s)
  - FactionSearchResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "faction/search"
  @response_modules [FactionSearchResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :name, value do
    # Name  to search for.
    {:query, :name, value}
  end

  @impl true
  defparameter :filters, value do
    # A filtering query parameter allowing a comma-separated list of filters.    * Each filter can be one of the following:  * Fixed options: 'destroyed', 'notDestroyed', 'recruiting', 'notRecruiting'  * Dynamic options: `fieldName`+`condition`+`number`, where:  * * `fieldName` is one of: `id`, `respect`, `members`  * * `condition` is one of: `Equal`, `NotEqual`, `Less`, `LessOrEqual`, `GreaterOrEqual`, `Greater`  * * `number`: any integer value  * Examples: `filters=destroyed`, `filters=notDestroyed,recruiting`, `filters=respectLessOrEqual20000,idGreater100,notRecruiting`
    {:query, :filters, value}
  end

  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end

  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
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
