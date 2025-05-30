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

defmodule Tornex.Query do
  @moduledoc """
  The query struct containing API request data.

  The `Tornex.Query` struct is utilized by `Tornex.API.torn_get/1` and `Tornex.Scheduler.Bucket.enqueue/1` to make API calls. `Tornex.Query` stores the required information to perform the API call.

  > #### Tip {: .tip}
  >
  > It is recommended to use `Tornex.SpecQuery` for APIv2 requests as it uses the OpenAPI specification to generate types and to parse and validate API responses. However, APIv2 does not currently support all of the selections that APIv1 supports, so you may have to remain on v1 for the immediate future.
  """

  defstruct [
    :resource,
    :resource_id,
    :key,
    :selections,
    :from,
    :to,
    :timestamp,
    :limit,
    :sort,
    :params,

    # Values required for the scheduler
    :key_owner,
    :nice,
    :origin
  ]

  @type t :: %__MODULE__{
          resource: String.t(),
          resource_id: Integer | String.t(),
          key: String.t(),
          selections: List,
          from: Integer,
          to: Integer,
          timestamp: Integer,
          limit: Integer,
          sort: :asc | :desc,
          params: Keyword,

          # Values required for the scheduler
          key_owner: Integer,
          nice: Integer,
          origin: GenServer.from() | nil
        }

  @doc """
  Determines the priority of a `Tornex.Query` by the `nice` value as a priority "bucket" atom.

  The nice value of a query is based on the Linux niceness value between -20 and 19. A niceness of -20 is the highest priority request and 19 is the lowest priority. For more information on the scheduling of requests against `Tornex.Query`, see `Tornex.Scheduler.Bucket`.

  There are three priority buckets:
  - generic requests (nice > 0) => Requests that are intended to be made with as much latency as needed
  - high priority requests (-10 < nice <= 0) => Requests where latency matters
  - user requests (nice <= -10) => Requests that should be performed immediately, typically initiated by a user action
  """
  @spec query_priority(query :: t() | Tornex.SpecQuery.t()) :: :user_request | :high_priority | :generic_request
  def query_priority(%Tornex.Query{} = query) do
    cond do
      query.nice <= -10 -> :user_request
      query.nice <= 0 -> :high_priority
      true -> :generic_request
    end
  end

  def query_priority(%Tornex.SpecQuery{} = query) do
    cond do
      query.nice <= -10 -> :user_request
      query.nice <= 0 -> :high_priority
      true -> :generic_request
    end
  end
end
