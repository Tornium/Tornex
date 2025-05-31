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
  - `client` (default: `Tornex.HTTP.FinchClient`) => HTTP client to use in API calls

  To customize one of these, include the following in a `config/*.exs`:

      config :tornex,
        base_url: "https://api.torn.com",
        comment: "Tornium",
  """

  # TODO: Document and provide examples for making API calls

  require Logger

  @http_client Application.compile_env(:tornex, :client, Tornex.HTTP.FinchClient)

  @type return :: list() | map()
  @type error :: {:error, :cf_challenge | :unknown | :content_type | Jason.DecodeError.t() | term()}

  @user_agent "Tornex/#{Mix.Project.config()[:version]} (#{@http_client.version()})"
  @base_url Application.compile_env(:tornex, :base_url, "https://api.torn.com")
  @comment Application.compile_env(:tornex, :comment, "tex-" <> Mix.Project.config()[:version])

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
      "https://api.torn.com/v2/faction/89/?selections=chains,basic&limit=100&comment=tex-#{Mix.Project.config()[:version]}"
  """
  @spec query_to_url(Tornex.Query.t() | Tornex.SpecQuery.t()) :: String.t()
  def query_to_url(%Tornex.Query{} = query) do
    uri =
      @base_url
      |> URI.new!()
      |> URI.append_path("/#{query.resource}/#{query.resource_id}")
      |> URI.append_query("selections=" <> Enum.join(query.selections || [], ","))
      |> URI.append_query("key=#{query.key}")
      |> URI.append_query("comment=#{@comment}")

    uri =
      if is_nil(query.from) do
        uri
      else
        URI.append_query(uri, "from=#{query.from}")
      end

    uri =
      if is_nil(query.to) do
        uri
      else
        URI.append_query(uri, "from=#{query.to}")
      end

    uri =
      if is_nil(query.timestamp) do
        uri
      else
        URI.append_query(uri, "timestamp=#{query.timestamp}")
      end

    uri =
      if is_nil(query.params) or not is_list(query.params) do
        uri
      else
        Enum.reduce(query.params, uri, fn {key, value}, acc -> URI.append_query(acc, "#{key}=#{value}") end)
      end

    URI.to_string(uri)
  end

  def query_to_url(%Tornex.SpecQuery{} = query) do
    query
    |> Tornex.SpecQuery.uri!()
    |> URI.append_query("comment=" <> @comment)
    |> URI.to_string()
  end

  @doc """
  Performs a blocking HTTP GET request against the Torn API for a `Tornex.Query` or `Tornex.SpecQuery`.

  ## Examples

      iex> query = %Tornex.Query{resource: "user", resource_id: 1, key: "", key_owner: 1, nice: 0}
      iex> Tornex.API.get(query)
      ...
  """
  @spec get(Tornex.Query.t()) :: map() | list() | error()
  def get(%Tornex.Query{} = query) do
    :telemetry.execute([:tornex, :api, :start], %{}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    # TODO: Validate query
    headers = %{"User-Agent" => @user_agent, "Content-Type" => "application/json"}
    {latency, response} = :timer.tc(&@http_client.get/2, [query_to_url(query), headers])

    :telemetry.execute([:tornex, :api, :finish], %{latency: latency}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    handle_response(response, query)
  end

  @spec get(Tornex.SpecQuery.t()) :: binary() | error()
  def get(%Tornex.SpecQuery{key: api_key} = query) when is_binary(api_key) do
    {path, selections} = Tornex.SpecQuery.path_selections!(query)

    resource =
      path
      |> String.split("/")
      |> Enum.at(0)

    :telemetry.execute([:tornex, :api, :start], %{}, %{
      resource: "v2/#{resource}",
      # TODO: Determine the resource ID from the parameters
      resource_id: nil,
      selections: selections,
      user: query.key_owner
    })

    headers = %{
      "User-Agent" => @user_agent,
      "Content-Type" => "application/json",
      "Authorization" => "ApiKey #{api_key}"
    }

    # TODO: Validate query
    {latency, response} = :timer.tc(&@http_client.get/2, [query_to_url(query), headers])

    :telemetry.execute([:tornex, :api, :finish], %{latency: latency}, %{
      resource: "v2/#{resource}",
      resource_id: nil,
      selections: selections,
      user: query.key_owner
    })

    handle_response(response, query)
  end

  @doc """
  Performs a blocking HTTP GET request against the Torn API for a `Tornex.Query` or `Tornex.SpecQuery`.

  ## Examples

      iex> query = %Tornex.Query{resource: "user", resource_id: 1, key: "", key_owner: 1, nice: 0}
      iex> Tornex.API.torn_get(query)
      ...
  """
  @deprecated "Use `get/1` instead"
  @spec torn_get(Tornex.Query.t()) :: map() | list() | error()
  def torn_get(%Tornex.Query{} = query) do
    :telemetry.execute([:tornex, :api, :start], %{}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    headers = %{"User-Agent" => @user_agent, "Content-Type" => "application/json"}
    {latency, response} = :timer.tc(&@http_client.get/2, [query_to_url(query), headers])

    :telemetry.execute([:tornex, :api, :finish], %{latency: latency}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    handle_response(response, query)
  end

  @deprecated "Use `get/1` instead"
  @spec torn_get(Tornex.SpecQuery.t()) :: term() | error()
  def torn_get(%Tornex.SpecQuery{key: api_key} = query) when is_binary(api_key) do
    {path, selections} = Tornex.SpecQuery.path_selections!(query)

    resource =
      path
      |> String.split("/")
      |> Enum.at(0)

    :telemetry.execute([:tornex, :api, :start], %{}, %{
      resource: resource,
      resource_id: nil,
      selections: selections,
      user: query.key_owner
    })

    headers = %{
      "User-Agent" => @user_agent,
      "Content-Type" => "application/json",
      "Authorization" => "ApiKey #{api_key}"
    }

    {latency, response} = :timer.tc(&@http_client.get/2, [query_to_url(query), headers])

    :telemetry.execute([:tornex, :api, :finish], %{latency: latency}, %{
      resource: resource,
      resource_id: nil,
      selections: selections,
      user: query.key_owner
    })

    handle_response(response, query)
  end

  @spec handle_response(response :: Tornex.HTTP.Client.response(), query :: Tornex.Query.t() | Tornex.SpecQuery.t()) ::
          return() | error()
  defp handle_response({:ok, 403 = _status, response_headers, response_body}, _query) do
    if Map.get(response_headers, "cf-mitigated") == "challenge" do
      {:error, :cf_challenge}
    else
      response_body
    end
  end

  # TODO: Parse error responses into new error struct
  defp handle_response({:ok, status, response_headers, response_body}, _query) do
    if Map.get(response_headers, "content-type") == "application/json" do
      case Jason.decode(response_body) do
        {:ok, parsed_body} -> parsed_body
        {:error, _} = error -> error
      end
    else
      {:error, :content_type}
    end
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
end
