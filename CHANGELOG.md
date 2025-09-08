# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.0] - 2025-09-08
### Added
- Added cluster mode
- Added server-side bucket timeouts
- Added `:ignored` option to `attach_default_logger/1` to not attach specified events

### Removed
- Removed `tornex.bucket.dump` telemetry event and PromEx counter

## [0.3.0] - 2025-06-29
### Changed
- Changed location of generated code from in-line to [torngen_elixir_client](https://github.com/Tornium/torngen_elixir_client)
- Changed usage of deprecated `torn_get/1` to `get/1`

### Fixed
- Fixed user agent creation in `Tornex.API` when using an external HTTP adapter implementation (#20)
- Fixed timeout option in `SpecQuery` enqueued in `Bucket`

## [0.2.0] - 2025-05-31
### Added
- APIv2 support through generated code from [torngen](https://github.com/Tornium/torngen)

### Changed
- Changed HTTP library from Tesla to an adapter with Finch as the default

### Deprecated
- Deprecated `Tornex.API.torn_get/1` in favor of `Tornex.API.get/1`

## [0.1.1] - 2025-04-18
### Added
- Added `opts.timeout` to `Bucket.enqueue/3` and `Bucket.enqueue/4`

### Fixed
- Fixed optional loading of `prom_ex`

## [0.1.0] - 2025-03-21
### Added
- Bucket-based ratelimiter
- Telemetry through `:telemetry` and PromEx
- Telsa-based API querying
