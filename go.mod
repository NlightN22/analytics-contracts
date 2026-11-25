module github.com/NlightN22/analytics-contracts

go 1.26.0

retract (
	v0.1.0 // superseded by v0.1.1, use v0.1.1 or later
	v0.4.0 // SalesMetricsService field numbers changed in v0.5.0; use v0.5.0 or later
	v0.4.1 // net_sales reused the number of a removed field; use v0.5.0 or later
)

require (
	google.golang.org/grpc v1.85.0
	google.golang.org/protobuf v1.36.12
)

require (
	golang.org/x/net v0.60.0 // indirect
	golang.org/x/sys v0.48.0 // indirect
	golang.org/x/text v0.42.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260817212433-ac3dfec99bb1 // indirect
)
