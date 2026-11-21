# analytics-contracts

Public gRPC/Protobuf contract of the Analytics API. The service itself lives in a separate private repository.

## Layout

| Path | Purpose |
|---|---|
| `proto/analytics/v1/` | `.proto` sources, package `analytics.v1` |
| `gen/go/` | generated Go code, committed |
| `buf.yaml`, `buf.gen.yaml` | lint, breaking-change and generation config |

## Commands

| Command | Action |
|---|---|
| `make lint` | `buf lint` |
| `make breaking` | `buf breaking` against the latest release tag |
| `make gen` | regenerate `gen/go` |
| `make check` | lint, breaking, and verify `gen/go` is up to date |
| `make release VERSION=v1.3.0` | run `check` and create a local tag |

## Versioning

- patch: comments and docs only.
- minor: backward-compatible additions to `analytics.v1` (new field, method, enum value).
- major: incompatible change, only as a new package `analytics.v2` next to `v1`; the Go module path gets a `/v2` suffix.

Never remove or renumber a published field; reserve it instead. Do not put internal system names, real identifiers or sensitive business terms into this repository: everything here is public and cannot be withdrawn.

## Tooling

Generated code in `gen/go` is produced with `buf` 1.75.0, `protoc-gen-go` v1.36.12 and `protoc-gen-go-grpc` 1.6.2; use the same versions to avoid noisy diffs. Commit with a neutral git identity: the history of this public repository is visible to everyone.
