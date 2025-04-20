defmodule Torngen.Client.Path.Torn do
  @moduledoc """
  Get any Torn selection.

  Requires public access key. <br> Choose one or more selections (comma separated).

  ## Parmeters
  - selections: Selection names
  - id: selection id
  - striptags: Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
  - limit: N/A
  - to: Timestamp until when rows are returned
  - from: Timestamp after when rows are returned
  - cat: Selection category
  - sort: Direction to sort rows in
  - offset: N/A

  ## Tags
  - Torn
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :selections, value do
    # Selection names
    {:query, :selections, value}
  end

  @impl true
  defparameter :id, value do
    # selection id
    {:query, :id, value}
  end

  @impl true
  defparameter :striptags, value do
    # Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
    {:query, :striptags, value}
  end

  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end

  @impl true
  defparameter :to, value do
    # Timestamp until when rows are returned
    {:query, :to, value}
  end

  @impl true
  defparameter :from, value do
    # Timestamp after when rows are returned
    {:query, :from, value}
  end

  @impl true
  defparameter :cat, value do
    # Selection category
    {:query, :cat, value}
  end

  @impl true
  defparameter :sort, value do
    # Direction to sort rows in
    {:query, :sort, value}
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
