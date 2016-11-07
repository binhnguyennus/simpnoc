`include "generator.v"
`include "router.v"
`include "source.v"
`include "sink.v"
`include "connector.v"

module noc (input clk, input reset);

	`include "gen_params.v"
	`include "wires.v"
	`include "gen_routers.v"
	`include "gen_tables.v"
	`include "gen_sources.v"
	`include "gen_sinks.v"
	`include "gen_connections.v"

endmodule
