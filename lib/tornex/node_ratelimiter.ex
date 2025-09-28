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

defmodule Tornex.NodeRatelimiter do
  @moduledoc """
  A module backed by an ETS to mark when a node is ratelimited.

  To make this easy to use and to prevent race conditions, this ETS is wrapped in a GenServer
  that needs to be started in the parent application's supervision tree.
  """

  use GenServer

  @table :tornex_node_ratelimiter

  @doc """
  Initialize the ETS table for the node ratelimiter.
  """
  @spec start_link(opts :: keyword()) :: :ets.table()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  Set this node to be ratelimited until the end of the current minute.
  """
  @spec set_ratelimited(opts :: keyword) :: term()
  def set_ratelimited(opts \\ []) do
    expires_at =
      %DateTime{DateTime.utc_now(:second) | second: 0}
      |> DateTime.add(60, :second)

    # This is an option for testing and not intended to be exposed
    expires_at = Keyword.get(opts, :expires_at, expires_at)
    timeout = Keyword.get(opts, :timeout, :infinity)

    GenServer.call(__MODULE__, {:set_ratelimited, expires_at}, timeout)
  end

  @doc """
  Check if this node is ratelimited.
  """
  @spec ratelimited?(opts :: keyword()) :: boolean()
  def ratelimited?(opts \\ []) do
    timeout = Keyword.get(opts, :timeout, :infinity)

    GenServer.call(__MODULE__, :ratelimited?, timeout)
  end

  @impl GenServer
  def init(_otps \\ []) do
    :ets.new(@table, [:set, :public, :named_table])

    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:set_ratelimited, %DateTime{} = expires_at}, _from, state) do
    :ets.insert(@table, {:flag, expires_at})

    {:reply, :ok, state}
  end

  @impl GenServer
  def handle_call(:ratelimited?, _from, state) do
    case :ets.lookup(@table, :flag) do
      [{:flag, %DateTime{} = expires_at}] ->
        return_value =
          DateTime.utc_now()
          |> DateTime.compare(expires_at)
          |> Kernel.==(:lt)

        {:reply, return_value, state}

      _ ->
        {:reply, false, state}
    end
  end
end
