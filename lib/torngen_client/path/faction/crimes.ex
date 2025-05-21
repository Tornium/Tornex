defmodule Torngen.Client.Path.Faction.Crimes do
  @moduledoc """
  Get your faction's organized crimes.

  Requires minimal access key with faction API access permissions. <br> It's possible to get older entries either by timestamp range (from, to) or with offset.

  ## Parmeters
  - cat: Category of organized crimes returned
  - offset: N/A
  - from: Timestamp that sets the lower limit for the data returned
  - to: Timestamp that sets the upper limit for the data returned
  - sort: Sorted by the greatest timestamps
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Minimal)

  ## Response Module(s)
  - FactionCrimesResponse
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "faction/crimes"
  @response_modules [FactionCrimesResponse]

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :cat, value do
    # Category of organized crimes returned. Category 'available' includes both 'recruiting' & 'planning', and category 'completed' includes both 'successful' & 'failure' Default category is 'all'
    {:query, :cat, value}
  end

  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
  end

  @impl true
  defparameter :from, value do
    # Timestamp that sets the lower limit for the data returned. Data returned will be after this time
    {:query, :from, value}
  end

  @impl true
  defparameter :to, value do
    # Timestamp that sets the upper limit for the data returned. Data returned will be up to and including this time
    {:query, :to, value}
  end

  @impl true
  defparameter :sort, value do
    # Sorted by the greatest timestamps
    {:query, :sort, value}
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
    # API key (Minimal). It's not required to use this parameter when passing the API key via the Authorization header.
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
