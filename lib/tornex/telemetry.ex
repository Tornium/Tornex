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

defmodule Tornex.Telemetry do
  @moduledoc """
  Telemetry for Tornex using `:telemetry`.

  `Tornex.Telemetry` defaults to using `Logger` to handle telemetry events, but this behavior can be 
  customized by not attaching the default telemetry handler.

  ## Telemetry Events
  Tornex dispatches the following events through `:telemetry`:

  * `[:tornex, :api, :start]`: Executed when there is an API call started against a `Tornex.Query` or
    a `Tornex.SpecQuery`.
    * Measurement: `%{}`
    * Metadata: `%{resource: String.t, resource_id: integer, selections: [String.t()], user: pos_integer}`

  * `[:tornex, :api, :finish]`: Executed when the API call started against a `Tornex.Query` or a
    `Tornex.SpecQuery` has finished.
    * Measurement: `%{latency: pos_integer}`
    * Metadata: `%{resource: String.t, resource_id: integer, selections: [String.t()], user: pos_integer}`

  * `[:tornex, :api, :error]`: Executed when an API call has failed.
    * Measurement: `%{}`
    * Metadata: `%{}`

  * `[:tornex, :api, :timeout]`: Executed when an API call is over the timeout value and the API call
    has been ended.
    * Measurement: `%{}`
    * Metadata: `%{}`

  * `[:tornex, :bucket, :create]`: Executed when a new `Tornex.Scheduler.Bucket` has been created
    for a user ID.
    * Measurement: `%{}`
    * Metadata: `%{user_id: pos_integer, pid: pid}`

  * `[:tornex, :bucket, :create_error]`: Executed when a `Tornex.Scheduler.Bucket` could not be created
    due to some issue.
    * Measurement: `%{}`
    * Metadata: `%{user_id: pos_integer, error: term}`

  * `[:tornex, :bucket, :timeout]`: Dispatched by a `Tornex.Scheduler.Bucket` when it has been empty
    for too long and has been killed.
    * Measurement: `%{}`
    * Metadata: `%{pid: pid}`

  * `[:tornex, :bucket, :enqueue]`: Dispatched by a `Tornex.Scheduler.Bucket` when a `Tornex.SpecQuery`
    has been run against it or has been enqueued to it.
    * Measurement: `%{}`
    * Metadata: `%{selections: [String.t], resource: String.t, optional(resource_id): integer, user: pos_integer}`
  """

  require Logger

  @handler_id "tornex-default-telemetry-handler"

  @doc """
  Attaches the default Tornex `:telemetry` handler built on-top of `Logger`.

  ## Options
    * `:ignored` - (list) List of events to not be attached
    * `:encode` - (bool)
    * `:level` - (atom) Minimum log level for telemetry events
  """
  @spec attach_default_logger(opts :: Keyword.t()) :: :ok | {:error, :already_exists}
  def attach_default_logger(opts \\ []) when is_list(opts) do
    ignored_events = Keyword.get(opts, :ignored, [])

    events =
      [
        [:tornex, :api, :start],
        [:tornex, :api, :finish],
        [:tornex, :api, :error],
        [:tornex, :api, :timeout],
        [:tornex, :bucket, :create],
        [:tornex, :bucket, :create_error],
        [:tornex, :bucket, :timeout],
        [:tornex, :bucket, :enqueue]
      ] -- ignored_events

    opts =
      opts
      |> Keyword.put_new(:encode, true)
      |> Keyword.put_new(:level, :info)

    :telemetry.attach_many(@handler_id, events, &__MODULE__.handle_event/4, opts)
  end

  @doc """
  Detaches the default Tornex telemetry handler.
  """
  @spec detach_default_logger() :: :ok | {:error, :not_found}
  def detach_default_logger() do
    :telemetry.detach(@handler_id)
  end

  @doc false
  def handle_event([:tornex, :api, :start], _measurements, metadata, _opts) do
    Logger.debug(
      "[#{metadata.resource}/#{resource_id(metadata)}?selections=#{Enum.join(metadata.selections || [], ",")}] Request started for #{metadata.user}"
    )
  end

  @doc false
  def handle_event([:tornex, :api, :finish], measurements, metadata, _opts) do
    Logger.debug(
      "[#{metadata.resource}/#{resource_id(metadata)}?selections=#{Enum.join(metadata.selections || [], ",")}] Request finished in #{measurements.latency} ms"
    )
  end

  @doc false
  def handle_event([:tornex, :api, :timeout], _measurements, metadata, _opts) do
    Logger.debug(
      "[#{metadata.resource}/#{resource_id(metadata)}?selections=#{Enum.join(metadata.selections || [], ",")}] Request failed due to timeout"
    )
  end

  @doc false
  def handle_event([:tornex, :api, :error], measurements, metadata, _opts) do
    Logger.info(
      "[#{metadata.resource}/#{resource_id(metadata)}?selections=#{Enum.join(metadata.selections || [], ",")}] Request failed due to #{metadata.error} in #{measurements.latency} ms"
    )
  end

  @doc false
  def handle_event([:tornex, :bucket, :create], _measurements, metadata, _opts) do
    Logger.info("Bucket (#{inspect(metadata.pid)}) created for #{metadata.user}")
  end

  @doc false
  def handle_event([:tornex, :bucket, :create_error], _measurements, metadata, _opts) do
    Logger.error("Bucket creation failed for #{metadata.user} due to an error: #{inspect(metadata.error)}")
  end

  @doc false
  def handle_event([:tornex, :bucket, :timeout], _measurements, metadata, _opts) do
    Logger.debug("Bucket #{inspect(metadata.pid)} timed out")
  end

  @doc false
  def handle_event([:tornex, :bucket, :enqueue], _measurements, metadata, _opts) do
    Logger.debug(
      "[#{metadata.resource}/#{resource_id(metadata)}?selections=#{Enum.join(Map.get(metadata, :selections) || [], ",")}] Request enqueue for #{metadata.user}"
    )
  end

  @doc false
  def handle_event([:tornex, _event_type, _event], _measurements, _metadata, _opts) do
    :ok
  end

  @spec resource_id(metadata :: map()) :: term()
  defp resource_id(%{resource_id: {_, id}}), do: id
  defp resource_id(%{resource_id: id}), do: id || ""
  defp resource_id(_), do: ""
end
