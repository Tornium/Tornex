# Tornex
An Elixir library providing robust API call planning and execution for the [Torn City](https://torn.com) API.

> #### NOTE
> Currently, tornex is intended to work on single-node deployments. Multi-node deployments will experience issues with ratelimiting.

## Features
- Efficient API ratelimiting and planning using buckets and priorities
- `:telemetry`-based logging (with included support for [PromEx](https://hex.pm/packages/prom_ex))
- Support for APIv1 and APIv2

## Roadmap
- [ ] Per-IP/node global ratelimit
- [ ] Combine similar queries to reduce throughput
- [ ] Multi-node support
- [ ] APIv2 struct coalescing using [torngen](https://github.com/Tornium/torngen)

## Installation
Once [available in Hex](https://hex.pm/docs/publish), the library can be installed
by adding `tornex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tornex, "~> 0.1.0"}
  ]
end
```

For latest changes, you can also install the library directly from [GitHub](https://github.com/Tornium/tornex):

```elixir
def deps do
  [
    {:tornex, github: "Tornium/tornex"}
  ]
end
```

## Usage
Add the supervisor `Tornex.Scheduler.supervisor` to your application supervisor. If you are using the default telemetry handler using `Tornex.Telemetry.attach_default_handler`, make sure to start the handler before starting the supervisor.

Create a `Tornex.Query` struct containing the request information:
```elixir
request = %Tornex.Query{
    resource: "v2/user",
    resource_id: 1,
    key: api_key,
    selections: ["criminalrecord", "basic"],
    key_owner: 2383326,
    nice: 10
}
```

The query struct must contain the following values:
- `resource`: The name of the resource in v1 or v2. Prepend with `v2/` if you're using APIv2.
- `resource_id`: The ID of the resource even if the request is against the key owner's user, faction, etc.
- `key`: The API key to be used.
- `key_owner`: Any other unique identifier (suggested to use Torn ID) of the API key owner.
- `nice`: The priority of the request (following the Linux niceness values) where -20 is the highest priority and 19 is the lowest priority.

The request can be enqueued into the key owner's queue with `Tornex.Scheduler.Bucket.enqueue/1` to be made depending on the request's priority and the state of the key owner's queue. Or the request can be performed immediately with `Tornex.API.torn_get/1` which performs no ratelimiting. Both methods are blocking though.

```elixir
response = Tornex.Scheduler.Bucket.enqueue(request)

case response do
    {:error, :timeout} ->
        IO.puts("timeout")

    {:error, _} ->
        IO.puts("unknown")

    %{"name" => name, "criminalrecord" => %{"total" => crime_count}} ->
        IO.puts("#{name} => #{crime_count} crimes")
end
```

## Documentation
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm). Once published, the docs can be found at <https://hexdocs.pm/tornex>.

## License
Copyright 2024-2025 tiksan

This project is licensed under Apache 2.0; see [LICENSE.md](LICENSE.md) for more details.
