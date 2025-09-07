# Cluster Mode
This document explains how to enable and use Tornex's cluster mode.

## Overview
Cluster mode leverages [horde](https://hex.pm/packages/horde) to allow Tornex to run across multiple BEAM nodes while distributing API calls and API ratelimiting across the nodes.

## Installation
Add [Tornex](https://hex.pm/packages/tornex) and [horde](https://hex.pm/packages/horde) to your `mix.exs`:

```elixir
defp deps do
  [
    {:tornex, "~> 0.4"},
    {:horde, "~> 0.9"}
  ]
end
```

## Setting Up Cluster Mode
1. Set the  `:local` configuration key to `false`.
2. Add the `Tornex.Scheduler.Supervisor` supervision tree to your application's supervision tree as normal.
3. Use a library such as [libcluster](https://hex.pm/packages/libcluster) to connect nodes to the cluster upon startup. Horde will automatically synchronize cluster membership and handle transferring `Tornex.Scheduler.Bucket` to new nodes.

## Using Tornex in Cluster Mode
When cluster mode is enabled, Tornex will:
- Distribute workers and processes across all nodes.
- Ensure unique process registration cluster-wide.
- Automatically handle node joins and leaves.

Use Tornex as usual; clustering is transparent. Workers and processes will be supervised and registered on any available node.

## Monitoring Cluster State
You can inspect cluster membership and running processes using Horde’s APIs:
```elixir
Horde.Cluster.members(Tornex.Registry)
Horde.Cluster.members(Tornex.Supervisor)
```

## Troubleshooting
- Ensure all nodes share the same cookie.
- Confirm network connectivity between nodes.
- Update the `horde_members` list or use libcluster for automatic discovery.
- Check log output for errors related to Horde or Tornex initialization.
