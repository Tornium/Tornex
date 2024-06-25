# Copyright 2024 tiksan
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

defmodule Tornix.API do
  alias Tornix.Query

  use Tesla

  @user_agent [{"User-agent", "tornix " <> Mix.Project.config()[:version]}]

  plug(Tesla.Middleware.BaseUrl, "https://api.torn.com")
  plug(Tesla.Middleware.Headers, @user_agent)
  plug(Tesla.Middleware.JSON)

  @spec append_resource_id(String.t(), Query.t()) :: String.t()
  defp append_resource_id(uri_string, %Query{resource_id: nil} = _) do
    uri_string
  end

  @spec append_resource_id(String.t(), Query.t()) :: String.t()
  defp append_resource_id(uri_string, query) when is_binary(query.resource_id) do
    uri_string <> query.resource_id
  end

  @spec append_resource_id(String.t(), Query.t()) :: String.t()
  defp append_resource_id(uri_string, query) when is_integer(query.resource_id) do
    uri_string <> Integer.to_string(query.resource_id)
  end

  @spec query_to_url(Query.t()) :: String.t()
  def query_to_url(query) do
    ("/" <> query.resource <> "/")
    |> append_resource_id(query)
    |> Tesla.build_url(
      selections: Enum.join(query.selections || [], ","),
      from: query.from || [],
      to: query.to || [],
      timestamp: query.timestamp || [],
      key: query.key,
      comment: "Tornix"
    )
  end

  @spec validate_api_error(Map) :: {:ok, Map} | {:error, {:api, Integer}}
  defp validate_api_error(response) when is_map(response) do
    case response["error"] do
      nil -> {:ok, response}
      %{"code" => error_code} -> {:error, {:api, error_code}}
    end
  end

  @spec validate_api_error({:error, any()}) :: {:error, any()}
  defp validate_api_error({:error, error}) do
    {:error, error}
  end

  @spec torn_get(Query.t()) :: {:ok, Map} | {:error, {:api, Integer}} | {:error, any()}
  def torn_get(query) do
    case get(query_to_url(query)) do
      {:ok, response} ->
        response.body
        |> validate_api_error()

      {:error, _} ->
        {:error, :unknown}
    end
  end
end
