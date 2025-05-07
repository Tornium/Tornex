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
        base_url: "https://api.torn.com",
        comment: "Tornium"
  """

  use Tesla

  @type return :: list() | map()
  @type error :: {:error, :timeout | :cf_challenge | :unknown | any()}

  @user_agent [{"User-agent", "tornex" <> Mix.Project.config()[:version]}]
  @base_url Application.compile_env(:tornex, :base_url, "https://api.torn.com")
  @comment Application.compile_env(:tornex, :comment, "tex/" <> Mix.Project.config()[:version])

  plug(Tesla.Middleware.BaseUrl, @base_url)
  plug(Tesla.Middleware.Headers, @user_agent)
  plug(Tesla.Middleware.JSON)

  @doc """
  Converts a `Tornex.Query` to the URL required to make the HTTP request.

      iex> query = %Tornex.Query{
      ...>   resource: "user",
      ...>   resource_id: 1,
      ...>   key: "apikey",
      ...>   key_owner: "apikey",
      ...>   nice: 10,
      ...>   selections: ["basic", "discord"]
      ...> }
      iex> Tornex.API.query_to_url(query)
      "https://api.torn.com/user/1?selections=basic,discord&key=apikey&comment=tex/#{Mix.Project.config()[:version]}"
  """
  @spec query_to_url(Tornex.Query.t()) :: String.t()
  def query_to_url(%Tornex.Query{} = query) do
    ("/" <> query.resource <> "/")
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
  end

  @doc """
  Performs a blocking HTTP GET request against the Torn API for the `Tornex.Query`.

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

    handle_response(query, response)
  end

  @spec handle_response(query :: Tornex.Query.t(), response :: tuple()) :: {:ok, return()} | error()
  defp handle_response(%Tornex.Query{} = _query, {:ok, %Tesla.Env{status: 403} = response}) do
    if Enum.member?(response.headers, {"cf-mitigated", "challenge"}) do
      {:error, :cf_challenge}
    else
      response.body
    end
  end

  defp handle_response(%Tornex.Query{} = _query, {:ok, %Tesla.Env{} = response}) do
    response.body
  end

  defp handle_response(%Tornex.Query{} = query, {:error, :timeout}) do
    :telemetry.execute([:tornex, :api, :timeout], %{}, %{
      resource: query.resource,
      resource_id: query.resource_id,
      selections: query.selections,
      user: query.key_owner
    })

    {:error, :timeout}
  end

  defp handle_response(%Tornex.Query{} = _query, {:error, reason}) do
    IO.inspect(reason, label: "Unknown Tornex error")

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
