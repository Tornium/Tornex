defmodule Torngen.Client.Path.User.Reports do
  @moduledoc """
  Get your reports.

  Requires limited access key. <br>
  * The default limit is set to 25. However, the limit can be set to 100 for the 'stats' category.

  ## Parmeters
  - cat: Used to filter reports with a specific type.
  - target: Get reports for a specific player by passing their player ID.
  - limit: N/A
  - offset: N/A
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Limited)

  ## Response Module(s)
  - ReportsResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/reports"
  @response_modules [ReportsResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :cat, value do
    # Used to filter reports with a specific type.
    {:query, :cat, value}
  end

  @impl true
  defparameter :target, value do
    # Get reports for a specific player by passing their player ID.
    {:query, :target, value}
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
    # API key (Limited). It's not required to use this parameter when passing the API key via the Authorization header.
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
