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
# 
# This file is adapted from lib/sentry/http_client.ex in the 
# getsentry/sentry-elixir project, which is licensed under
# the MIT License. The original source is available at:
# https://github.com/getsentry/sentry-elixir/blob/10.10.0/lib/sentry/http_client.ex

defmodule Tornex.HTTP.Client do
  @moduledoc """
  The behaviours of HTTP client implementations for `Tornex.API.get/1`.

  Unless otherwise configured with `config :tornex, client: AlternateClient`, the default HTTP client is
  `Tornex.HTTP.FinchClient`.

  The `child_spec/1` callback is optional and should be configured for HTTP libraries that require a 
  supervision tree.
  """

  @typedoc """
  HTTP status code of the HTTP request.
  """
  @type status() :: 100..599

  @typedoc """
  HTTP headers for the HTTP request or response.
  """
  @type headers() :: %{String.t() => String.t()}

  @typedoc """
  Body of the HTTP response.
  """
  @type body() :: binary()

  @type response() :: {:ok, status(), response_headers :: headers(), response_body :: body()} | {:error, term()}

  @doc """
  Optionally get a child spec to start the HTTP client.
  """
  @callback child_spec(opts :: Keyword.t()) :: Supervisor.child_spec()

  @doc """
  Get the name of the library and its version.
  """
  @callback version() :: String.t()

  @doc """
  Perform an HTTP GET to the specified URL with the headers.
  """
  @callback get(url :: String.t(), request_headers :: headers()) :: response()

  @optional_callbacks [child_spec: 1]
end
