# Copyright 2024-2025 tiksan
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule Tornex.API do
  @moduledoc """
  Core API functionality.

  `Tornex.API` provides the core Torn API-related functionality to make the API calls.

  ## Configuration
  Tornex uses compile-time configuration for certain API-related functionality:
  - `base_url` (default: "https://api.torn.com") => base of the URL the remainder of the request URL is built off of
  - `comment` (default: "tex/#{Mix.Project.config()[:version]}") => Comment used in the API calls

  To customize one of these, include the following in a `config/*.exs`:

      config :tornex,
        base_url: "https://tornium.com/api/v1",
        comment: "Tornium"
  """

  # TODO: Document and provide examples for making API calls

  require Logger
  use Tesla

  @type return :: list() | map()
  @type error :: {:error, :timeout | :cf_challenge | :unknown | term()}

  @user_agent [{"User-agent", "tornex" <> Mix.Project.config()[:version]}]
  @base_url Application.compile_env(:tornex, :base_url, "https://api.torn.com")
  @comment Application.compile_env(:tornex, :comment, "tex-" <> Mix.Project.config()[:version])

  plug(Tesla.Middleware.Headers, @user_agent)
  plug(Tesla.Middleware.JSON)

  @doc ~S"""
  Converts a `Tornex.Query` or `Tornex.SpecQuery` to the URL required to make the HTTP request.

      iex> query = %Tornex.Query{
      ...>   resource: "user",
      ...>   resource_id: 1,
      ...>   key: "apikey",
      ...>   key_owner: "apikey",
      ...>   nice: 10,
      ...>   selections: ["basic", "discord"]
      ...> }
      iex> Tornex.API.query_to_url(query)
      "https://api.torn.com/user/1?selections=basic,discord&key=apikey&comment=tex-#{Mix.Project.config()[:version]}"

      iex> spec_query =
      ...>   Tornex.SpecQuery.new()
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Basic)
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Chains)
      ...>   |> Tornex.SpecQuery.put_parameter(:id, 89)
      ...>   |> Tornex.SpecQuery.put_parameter(:limit, 100)
      ...>   |> Tornex.SpecQuery.put_key("apikey")
      iex> Tornex.API.query_to_url(spec_query)
      "https://api.torn.com/v2/faction/89/?selections=chains,basic&key=apikey&limit=100&comment=tex-#{Mix.Project.config()[:version]}"
  """
  @spec query_to_url(Tornex.Query.t() | Tornex.SpecQuery.t()) :: String.t()
  def query_to_url(%Tornex.Query{} = query) do
    (@base_url <> "/" <> query.resource <> "/")
    |> append_resource_id(query)
    |> Tesla.build_url(
      [
        selections: Enum.join(query.selections || [], ","),
        from: query.from || [],
        to: query.to || [],
        timestamp: query.timestamp || [],
        key: query.key,
        comment: @comment
      ] ++ (query.params || [])
    )
    |> String.replace("%2C", ",")

    # Replacing `%2C` with `,` is necessary when joining the selections where Tesla escapes the comma
  end

  def query_to_url(%Tornex.SpecQuery{} = query) do
    query
    |> Tornex.SpecQuery.uri()
    |> URI.append_query("comment=" <> @comment)
    |> URI.to_string()
  end

  @doc """
  Performs a blocking HTTP GET request against the Torn API for a `Tornex.Query` or `Tornex.SpecQuery`.

  ## Examples

      iex> query = %Tornex.Query{resource: "user", resource_id: 1, key: "", key_owner: 1, nice: 0}
      iex> Tornex.API.torn_get(query)
      ...
  """
  @spec torn_get(Tornex.Query.t()) :: map() | list() | error()
  def torn_get(%Tornex.Query{} = query) do
    :telemetry.execute([:tornex, :api, :start], %{}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    # TODO: Validate query
    # TODO: Replace Tesla.get with some other library (e.g. Req)
    # TODO: Switch `torn_get` to `get` and deprecate `torn_get`
    {latency, response} = :timer.tc(&get/1, [query_to_url(query)])

    :telemetry.execute([:tornex, :api, :finish], %{latency: latency}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    handle_response(response, query)
  end

  @spec torn_get(Tornex.SpecQuery.t()) :: term() | error()
  def torn_get(%Tornex.SpecQuery{} = query) do
    {path, selections} = Tornex.SpecQuery.path_selections!(query)

    resource =
      path
      |> String.split("/")
      |> Enum.at(0)

    :telemetry.execute([:tornex, :api, :start], %{}, %{
      resource: resource,
      # TODO: Determine the resource ID from the parameters
      resource_id: nil,
      selections: selections,
      user: query.key_owner
    })

    # TODO: Validate query
    # TODO: Replace Tesla.get with some other library (e.g. Req)
    # TODO: Switch `torn_get` to `get` and deprecate `torn_get`
    # TODO: Switch `torn_get` to use the `Authentication` header instead of a query parameter
    {latency, response} = :timer.tc(&get/1, [query_to_url(query)])

    :telemetry.execute([:tornex, :api, :finish], %{latency: latency}, %{
      resource: resource,
      resource_id: nil,
      selections: selections,
      user: query.key_owner
    })

    handle_response(response, query)
  end

  @spec handle_response(response :: tuple(), query :: Tornex.Query.t() | Tornex.SpecQuery.t()) ::
          {:ok, return()} | error()
  defp handle_response({:ok, %Tesla.Env{status: 403} = response}, _query) do
    if Enum.member?(response.headers, {"cf-mitigated", "challenge"}) do
      {:error, :cf_challenge}
    else
      response.body
    end
  end

  # TODO: Parse error responses into new error struct
  defp handle_response({:ok, %Tesla.Env{} = response}, _query) do
    response.body
  end

  defp handle_response({:error, :timeout}, %Tornex.Query{} = query) do
    :telemetry.execute([:tornex, :api, :timeout], %{}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    {:error, :timeout}
  end

  defp handle_response({:error, :timeout}, %Tornex.SpecQuery{} = query) do
    {path, selections} = Tornex.SpecQuery.path_selections!(query)

    resource =
      path
      |> String.split("/")
      |> Enum.at(0)

    :telemetry.execute([:tornex, :api, :timeout], %{}, %{
      resource: resource,
      # TODO: Determine the resource ID from the parameters
      resource_id: nil,
      selections: selections,
      user: query.key_owner
    })

    {:error, :timeout}
  end

  defp handle_response({:error, reason}, _query) do
    Logger.warning("Unknown Tornex error: #{inspect(reason)}")

    {:error, :unknown}
  end

  @spec append_resource_id(String.t(), Tornex.Query.t()) :: String.t()
  defp append_resource_id(uri_string, %Tornex.Query{resource_id: nil} = _) do
    uri_string
  end

  defp append_resource_id(uri_string, query) when is_binary(query.resource_id) do
    uri_string <> query.resource_id
  end

  defp append_resource_id(uri_string, query) when is_integer(query.resource_id) do
    uri_string <> Integer.to_string(query.resource_id)
  end

  # NOTE: Disable the docs on all the functions originating from Tesla
  # TODO: Disable docs on type `option()`

  @doc false
  def delete(_client, _url, _opts)

  @doc false
  def delete!(_client, _url, _opts)

  @doc false
  def get(_client, _url, _opts)

  @doc false
  def get!(_client, _url, _opts)

  @doc false
  def head(_client, _url, _opts)

  @doc false
  def head!(_client, _url, _opts)

  @doc false
  def options(_client, _url, _opts)

  @doc false
  def options!(_client, _url, _opts)

  @doc false
  def patch(_client, _url, _body, _opts)

  @doc false
  def patch!(_client, _url, _body, _opts)

  @doc false
  def post(_client, _url, _body, _opts)

  @doc false
  def post!(_client, _url, _body, _opts)

  @doc false
  def put(_client, _url, _body, _opts)

  @doc false
  def put!(_client, _url, _body, _opts)

  @doc false
  def request(_client, _options)

  @doc false
  def request!(_client, _options)

  @doc false
  def trace(_client, _url, _opts)

  @doc false
  def trace!(_client, _url, _opts)
end
