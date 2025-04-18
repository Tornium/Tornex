# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Added `opts.timeout` to `Bucket.enqueue/3` and `Bucket.enqueue/4`

### Fixed
- Fixed optional loading of `prom_ex`

## [0.1.0] - 2025-03-21
### Added
- Bucket-based ratelimiter
- Telemetry through `:telemetry` and PromEx
- Telsa-based API querying
