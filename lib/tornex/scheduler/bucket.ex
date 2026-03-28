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

defmodule Tornex.Scheduler.Bucket do
  @moduledoc """
  Representation of a user's bucket for API requests used for rate-limiting and prioritization.

  A bucket can contain as many API requests as the BEAM VM and the memory can handle. However,
  each bucket will only process 10 API requests every 6 seconds.

  The bucket provides the `enqueue/1` and `enqueue/2` operations providing the core functionality
  of this module:
  - creating the bucket if necessary,
  - handling telemetry,
  - and request handling.

  ## Bucket Creation
  Creating buckets is not required, but you can create and store buckets in a different manner
  if you need to do so.

  A buckets can be created with the following two methods:
    - `new/1` to create a bucket and store the PID of the GenServer manually
    - `enqueue/1` to create a bucket and let Tornex store the PID of the GenServer in a pre-initialized
       registry `Tornex.Scheduler.BucketRegistry`

  ## Making API Requests
  API requests are made with the `enqueue/1` and the `enqueue/2` operations with a `Tornex.Query`
  or `Tornex.SpecQuery` struct. The operations will then wait until the API call has been
  scheduled and the Torn API has responded instead of ending the invocation early and using
  a later `await`-like function.

  However, for example, this can still be done with the built-in `Task` module (including to
  handle many API requests at once): 

      1..10
      |> Enum.map(fn n ->
        Task.async(fn ->
          Tornex.Scheduler.Bucket.enqueue(pid, query)
        end)
      end)
      |> Task.await_many(timeout)

  If the query is a `Tornex.SpecQuery` that can be combined with any other `Tornex.SpecQuery`, including
  those from other buckets, the set of queries will be merged into a `Tornex.Scheduler.ExecutionUnit`
  that will be executed as one API call. The response of this API call will be split into the necessary
  components for each `Tornex.SpecQuery` and these components will be returned as if the query was
  performed directly. For more information, see `Tornex.Scheduler.QueryRegistry` and
  `Tornex.Scheduler.ExecutionUnit`.

  ## Bucket Timeouts
  By default, the bucket will never time out when the bucket does not receive any requests.
  This can be configured in milliseconds globally using the `:bucket_ttl` configuration key
  or per-bucket using the `:ttl` option when starting the bucket. If the bucket does not
  receive any requests for the specified amount of time, the bucket will be stopped and removed
  from its supervisor. If a request is later enqueued for the removed bucket's user, a new
  bucket will be created.
  """

  # This needs to be transient to ensure timed-out buckets are not restarted multiple times.
  use GenServer, restart: :transient

  @bucket_capacity 10
  @bucket_ttl Application.compile_env(:tornex, :bucket_ttl, :infinity)

  @type state :: %{
          query_priority_queue: [Tornex.Query.t() | Tornex.SpecQuery.t()],
          pending_count: non_neg_integer(),
          dumping?: boolean(),
          dump_remaining: non_neg_integer(),
          ttl: timeout(),
          timeout: pos_integer() | nil
        }

  @doc """
  Starts the bucket for a user.

  ## Options
    * `:user_id` - (any) A required unique identifier for the user the bucket belongs to
    * `:ttl` - (integer) Time in milliseconds before the bucket will be stopped without any requests (defaults to `:bucket_ttl`)

  ## Examples
      iex> Tornex.Scheduler.Bucket.start_link(user_id: 2383326, ttl: 10_000)
      {:ok, process}
      iex> is_pid(process)
      true
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    user_id = Keyword.fetch!(opts, :user_id)

    GenServer.start_link(
      __MODULE__,
      opts,
      name: {:via, Tornex.Scheduler.bucket_registry(), {Tornex.Scheduler.BucketRegistry, user_id}}
    )
  end

  @doc """
  Attempts to start a `Tornex.Scheduler.Bucket` and return the `pid` of a bucket.

  The `Tornex.Scheduler.Supervisor` will attempt to start the bucket as a child. If the bucket does not exist,
  the bucket will be created and the `pid` of the bucket will be returned. If the bucket is already a child of
  `Tornex.Scheduler.Supervisor`, the `pid` of the existing bucket will be returned.

  If there is an error in retrieving the `pid` of the bucket or an error in creating the bucket (e.g. maximum
  number of children in the supervisor reached), `nil` will be returned.

  ## Options
    * `:ttl` - (integer) Time in milliseconds before the bucket will be stopped without any requests (defaults to `:bucket_ttl`)

  ## Examples
      iex> Tornex.Scheduler.Bucket.new(2383326)
      {:nonode@host, #PID<0.105.0>}
  """
  @spec new(user_id :: integer(), opts :: keyword()) :: {node(), pid()} | nil
  def new(user_id, opts \\ []) when is_integer(user_id) do
    bucket = do_start_bucket(user_id, opts)

    case bucket do
      {:ok, pid} ->
        :telemetry.execute([:tornex, :bucket, :create], %{}, %{user: user_id, pid: pid})
        {node(pid), pid}

      {:ok, pid, _info} ->
        :telemetry.execute([:tornex, :bucket, :create], %{}, %{user: user_id, pid: pid})
        {node(pid), pid}

      {:error, {:already_started, pid}} ->
        {node(pid), pid}

      {:error, error} ->
        :telemetry.execute([:tornex, :bucket, :create_error], %{}, %{user: user_id, error: error})
        nil
    end
  end

  @doc false
  @spec do_start_bucket(user_id :: integer, opts :: keyword()) :: DynamicSupervisor.on_start_child()
  def do_start_bucket(user_id, opts \\ []) do
    opts = Keyword.put(opts, :user_id, user_id)
    Tornex.Scheduler.bucket_supervisor().start_child(Tornex.Scheduler.BucketSupervisor, {__MODULE__, opts})
  end

  @doc """
  Enqueues a `Tornex.Query` or `Tornex.SpecQuery` to the queue of the `Tornex.Scheduler.Bucket` for the API key's user.

  The `pid` of the bucket belonging to the API key's user will be retrieved with `Tornex.Scheduler.Bucket.get_by_id/1`,
  and will be used to enqueue the query for that specific bucket.

  ## Options
    * `:timeout` - Timeout of the GenServer call in milliseconds (default: `60_000`)
  """
  @spec enqueue(query :: Tornex.Query.t() | Tornex.SpecQuery.t(), opts :: Keyword.t()) :: term()
  def enqueue(query, opts \\ [])

  def enqueue(%{key_owner: key_owner} = query, opts)
      when is_integer(key_owner) and (is_struct(query, Tornex.Query) or is_struct(query, Tornex.SpecQuery)) do
    pid =
      case get_by_id(key_owner) do
        {:ok, pid} ->
          pid

        :error ->
          {_node, pid} = new(key_owner)
          pid
      end

    enqueue(pid, query, opts)
  end

  @doc false
  @spec enqueue(pid :: pid(), query :: Tornex.Query.t() | Tornex.SpecQuery.t(), opts :: Keyword.t()) :: term()
  def enqueue(pid, %Tornex.Query{key_owner: key_owner} = query, opts)
      when is_pid(pid) and is_integer(key_owner) do
    :telemetry.execute([:tornex, :bucket, :enqueue], %{}, %{
      selections: query.selections,
      resource: query.resource,
      user: key_owner
    })

    timeout = Keyword.get(opts, :timeout, 60_000)

    GenServer.call(pid, {:enqueue, query}, timeout)
  end

  def enqueue(pid, %Tornex.SpecQuery{key_owner: key_owner} = query, opts) when is_pid(pid) and is_integer(key_owner) do
    {base_path, selections} = Tornex.SpecQuery.path_selections!(query)

    :telemetry.execute([:tornex, :bucket, :enqueue], %{}, %{
      selections: selections,
      resource: base_path |> String.split("/") |> Enum.at(0),
      resource_id: Tornex.SpecQuery.resource_id!(query),
      user: key_owner
    })

    timeout = Keyword.get(opts, :timeout, 60_000)

    GenServer.call(pid, {:enqueue, query}, timeout)
  end

  @doc false
  @spec dump(bucket_pid :: pid(), timeout :: timeout()) :: term()
  def dump(bucket_pid, timeout \\ :infinity) when is_pid(bucket_pid) do
    GenServer.call(bucket_pid, :dump, timeout)
  end

  @doc """
  Remove a `Tornex.Query` or `Tornex.SpecQuery` from the queue of queries belonging to the bucket of the owner
  of the API key used fr the query.
  """
  @spec pop!(query :: Tornex.Query.t() | Tornex.SpecQuery.t(), opts :: keyword()) :: :ok
  def pop!(%module{key_owner: key_owner} = query, opts \\ [])
      when module in [Tornex.Query, Tornex.SpecQuery] and is_integer(key_owner) do
    {:ok, bucket_pid} = get_by_id(key_owner)
    timeout = Keyword.get(opts, :timeout, 60_000)
    GenServer.call(bucket_pid, {:pop, query}, timeout)
  end

  @doc """
  Retrieves the `pid` of the bucket by the bucket's user ID.

  Using the `Tornex.Scheduler.BucketRegistry` that creates the relationship between the bucket and the user ID upon
  bucket creation, the `pid` of the bucket will be returned. If a bucket is not registered for that user, `:error`
  will be returned.
  """
  @spec get_by_id(user_id :: integer()) :: {:ok, pid()} | :error
  def get_by_id(user_id) when is_integer(user_id) do
    case GenServer.whereis({:via, Tornex.Scheduler.bucket_registry(), {Tornex.Scheduler.BucketRegistry, user_id}}) do
      pid when is_pid(pid) -> {:ok, pid}
      _ -> :error
    end
  end

  @doc false
  @impl true
  def init(opts \\ []) do
    ttl = Keyword.get(opts, :ttl, @bucket_ttl)
    timeout = timeout(ttl)

    {
      :ok,
      %{query_priority_queue: [], pending_count: 0, dumping?: false, dump_remaining: 0, ttl: ttl, timeout: timeout},
      ttl
    }
  end

  @doc false
  @impl true
  def handle_call(
        {:enqueue, %module{key_owner: query_key_owner} = query},
        from,
        %{ttl: ttl, query_priority_queue: query_priority_queue, pending_count: pending_count} = state
      )
      when module in [Tornex.Query, Tornex.SpecQuery] do
    # Add from to query in case the request is dumped for the reply to be sent
    query = %{query | origin: from}
    timeout = timeout(ttl)

    cond do
      Tornex.Query.query_priority(query) == :user_request and pending_count < @bucket_capacity and
          not Tornex.NodeRatelimiter.ratelimited?() ->
        # Request has a niceness indicating it's a user request and there's available space in the 
        # bucket to perform the request. Additionally, this node is not ratelimited so the request can
        # be made.

        # We will want to check if there are any other pending requests that can be combined into this
        # query before making this request.
        merged_query = Tornex.Scheduler.QueryRegistry.merge(query)
        make_request(merged_query)

        state =
          case merged_query do
            %Tornex.Scheduler.ExecutionUnit{key_owner: key_owner, parents: merged_query_parents}
            when key_owner != query_key_owner ->
              # We only want to increase the pending count of the Bucket if the user's key is being used as
              # otherwise we would be unnecessarily preventing a user's bucket from making queries.
              #
              # We want to remove other queries used in the executed unit from the bucket if they are in the
              # bucket. Other queries not in the bucket will be handled by the QueryRegistry. Only these
              # belonging to this bucket are being done directly to avoid blocking the bucket and to avoid
              # racing conditions.
              updated_queue = Enum.reject(query_priority_queue, &Enum.member?(merged_query_parents, &1))

              state
              |> Map.replace(:timeout, timeout)
              |> Map.replace(:query_priority_queue, updated_queue)

            _ ->
              state
              |> Map.replace(:pending_count, pending_count + 1)
              |> Map.replace(:timeout, timeout)
          end

        {:noreply, state, ttl}

      Tornex.Query.query_priority(query) in [:user_request, :high_priority] and pending_count < 0.7 * @bucket_capacity and
          not Tornex.NodeRatelimiter.ratelimited?() ->
        # Request has a niceness indicating it's a user request or high priority and there's available 
        # space in the bucket to perform the request. Additionally, this node is not ratelimited so the
        # request can be made.

        # We will want to check if there are any other pending requests that can be combined into this
        # query before making this request.
        merged_query = Tornex.Scheduler.QueryRegistry.merge(query)
        make_request(merged_query)

        state =
          case merged_query do
            %Tornex.Scheduler.ExecutionUnit{key_owner: key_owner, parents: merged_query_parents}
            when key_owner != query_key_owner ->
              # We only want to increase the pending count of the Bucket if the user's key is being used as
              # otherwise we would be unnecessarily preventing a user's bucket from making queries.
              #
              # We want to remove other queries used in the executed unit from the bucket if they are in the
              # bucket. Other queries not in the bucket will be handled by the QueryRegistry. Only these
              # belonging to this bucket are being done directly to avoid blocking the bucket and to avoid
              # racing conditions.
              updated_queue = Enum.reject(query_priority_queue, &Enum.member?(merged_query_parents, &1))

              state
              |> Map.replace(:timeout, timeout)
              |> Map.replace(:query_priority_queue, updated_queue)

            _ ->
              state
              |> Map.replace(:pending_count, pending_count + 1)
              |> Map.replace(:timeout, timeout)
          end

        {:noreply, state, ttl}

      true ->
        # Either:
        #  - Request has a niceness indicating it's a user request or high priority request but there's not 
        #    available space in the bucket to perform the request and thus is queued
        #  - Request has a niceness of greater than 0 and therefore isn't high enough priority and should
        #    be queued
        #  - The node was ratelimited when the request was enqueued, so the query was enqueued until the
        #    node is not ratelimited anymore (while the dump signal is sent).

        # Sorts inserted query with higher priority queries at the start
        updated_queue = Enum.sort_by([query | query_priority_queue], & &1.nice, :asc)
        Tornex.Scheduler.QueryRegistry.insert(query)

        state =
          state
          |> Map.replace(:query_priority_queue, updated_queue)
          |> Map.replace(:timeout, timeout)

        {:noreply, state, ttl}
    end
  end

  @doc false
  @impl true
  def handle_call({:pop, %module{} = query}, _from, %{query_priority_queue: pending_queue} = state)
      when module in [Tornex.Query, Tornex.SpecQuery] do
    updated_queue = Enum.reject(pending_queue, &(&1 == query))

    {:reply, :ok, %{state | query_priority_queue: updated_queue}, remaining_ttl(state)}
  end

  @doc false
  @impl true
  def handle_call(:dump, _from, %{dumping?: false, pending_count: pending_count} = state)
      when pending_count >= @bucket_capacity do
    # The bucket is at capacity, so the dump will need to wait for the next time it's triggered.
    {:reply, :ok, state, remaining_ttl(state)}
  end

  @impl true
  def handle_call(:dump, _from, %{pending_count: pending_count, dumping?: false, dump_remaining: 0} = state) do
    # This is the first time the dump has been triggered, so we'll want to reset the pending count so that
    # the bucket can continue to make requests. We'll also want to start the dumping individual requests.
    updated_state = %{state | pending_count: 0, dumping?: true, dump_remaining: @bucket_capacity - pending_count}

    {:reply, :ok, updated_state, {:continue, :dump}}
  end

  @impl true
  def handle_continue(
        :dump,
        %{dumping?: true, dump_remaining: dump_remaining, query_priority_queue: query_priority_queue} = state
      )
      when dump_remaining == 0 or query_priority_queue == [] do
    # The bucket was in the process of dumping and has finished dumping either by having a dump_remaining
    # count of 0 or having an empty queue of queries.

    updated_state = %{state | dumping?: false, dump_remaining: 0}
    {:noreply, updated_state, remaining_ttl(updated_state)}
  end

  @impl true
  def handle_continue(
        :dump,
        %{
          dumping?: true,
          dump_remaining: dump_remaining,
          query_priority_queue: [%Tornex.Query{} = query | remaining_queries]
        } = state
      ) do
    updated_state =
      if Tornex.NodeRatelimiter.ratelimited?() do
        # The node is ratelimited so query can't be dumped. We should finish the dump early
        # to avoid sending more requests to Torn.
        %{state | dump_remaining: 0}
      else
        make_request(query)

        state
        |> Map.replace(:dump_remaining, dump_remaining - 1)
        |> Map.replace(:query_priority_queue, remaining_queries)
      end

    {:noreply, updated_state, {:continue, :dump}}
  end

  @impl true
  def handle_continue(
        :dump,
        %{
          dumping?: true,
          dump_remaining: dump_remaining,
          query_priority_queue: [%Tornex.SpecQuery{quarantine: true} = query | remaining_queries]
        } = state
      ) do
    updated_state =
      if Tornex.NodeRatelimiter.ratelimited?() do
        # The node is ratelimited so query can't be dumped. We should finish the dump early
        # to avoid sending more requests to Torn.
        %{state | dump_remaining: 0}
      else
        make_request(query)

        state
        |> Map.replace(:dump_remaining, dump_remaining - 1)
        |> Map.replace(:query_priority_queue, remaining_queries)
      end

    {:noreply, updated_state, {:continue, :dump}}
  end

  @impl true
  def handle_continue(
        :dump,
        %{
          dumping?: true,
          dump_remaining: dump_remaining,
          query_priority_queue: [%Tornex.SpecQuery{} = query | remaining_queries]
        } = state
      ) do
    updated_state =
      if Tornex.NodeRatelimiter.ratelimited?() do
        # The node is ratelimited so query can't be dumped. We should finish the dump early
        # to avoid sending more requests to Torn.
        %{state | dump_remaining: 0}
      else
        updated_queue =
          case Tornex.Scheduler.QueryRegistry.merge(query) do
            %Tornex.Scheduler.ExecutionUnit{parents: merged_query_parents} = merged_query ->
              make_request(merged_query)

              # We want to remove other queries used in the executed unit from the bucket if they are in the
              # bucket. Other queries not in the bucket will be handled by the QueryRegistry. Only these
              # belonging to this bucket are being done directly to avoid blocking the bucket and to avoid
              # racing conditions.
              Enum.reject(remaining_queries, &Enum.member?(merged_query_parents, &1))

            %Tornex.SpecQuery{} = merged_query ->
              make_request(merged_query)

              Enum.reject(remaining_queries, &(&1 == merged_query))
          end

        state
        |> Map.replace(:dump_remaining, dump_remaining - 1)
        |> Map.replace(:query_priority_queue, updated_queue)
      end

    {:noreply, updated_state, {:continue, :dump}}
  end

  @doc false
  @impl true
  def handle_info(:timeout, %{query_priority_queue: query_priority_queue} = state)
      when query_priority_queue == [] do
    # We only want to shut down buckets where the queue is empty to avoid any issues with the 
    # QueryRegistry and ExecutionUnits attempting to modify the queue after it has shutdown

    :telemetry.execute([:tornex, :bucket, :timeout], %{}, %{pid: self()})
    {:stop, :shutdown, state}
  end

  @doc false
  @impl true
  def handle_info(:timeout, %{ttl: ttl} = state) do
    {:noreply, state, ttl}
  end

  @doc false
  @impl true
  def handle_info(_msg, state) when is_map(state) do
    # This is needed to catch extraneous messages and prevent the GenServer from crashing/restarting
    {:noreply, state, remaining_ttl(state)}
  end

  @doc false
  @spec make_request(query :: Tornex.Query.t() | Tornex.SpecQuery.t() | Tornex.Scheduler.ExecutionUnit.t()) :: Task.t()
  def make_request(%Tornex.Scheduler.ExecutionUnit{parents: [%Tornex.SpecQuery{} = parent]} = _query) do
    # If there is only one parent in the ExecutionUnit, we should short-circuit the request and shunt it
    # to the normal Tornex.API.get flow to avoid excess processing (and to reduce the potential and
    # effect of bugs).

    make_request(parent)
  end

  def make_request(%Tornex.Scheduler.ExecutionUnit{} = query) do
    Task.Supervisor.async_nolink(Tornex.Scheduler.TaskSupervisor, fn -> Tornex.Scheduler.ExecutionUnit.get(query) end)
  end

  def make_request(%{origin: from} = query) do
    Task.Supervisor.async_nolink(Tornex.Scheduler.TaskSupervisor, fn -> GenServer.reply(from, Tornex.API.get(query)) end)
  end

  @spec timeout(ttl :: :infinity | non_neg_integer()) :: non_neg_integer() | nil
  defp timeout(:infinity = _ttl) do
    nil
  end

  defp timeout(ttl) when is_integer(ttl) do
    System.monotonic_time(:millisecond) + ttl
  end

  @spec remaining_ttl(state :: state()) :: non_neg_integer() | nil
  defp remaining_ttl(%{timeout: timeout} = _state) when is_nil(timeout) do
    :infinity
  end

  defp remaining_ttl(%{timeout: timeout, ttl: ttl} = _state) do
    if timeout - System.monotonic_time(:millisecond) < 0 do
      # The timeout value is older than the current time. To be safe, we'll extend the timeout.
      ttl
    else
      # The time remaining on the TTL before the dump signal was received.
      timeout - System.monotonic_time(:millisecond)
    end
  end
end
