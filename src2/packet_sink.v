`ifndef _inc_packet_sink_
`define _inc_packet_sink_

`include "debug_tasks.v"

module packet_sink (
		clk,
		reset,
		ch_req,
		ch_flit,
		ch_ack
	);

	// parameters:

	parameter SIZE = 8; // flit size (bits)
	parameter BUFF_BITS = 3; // buffer address bits

	localparam FLIT_COUNT = 2 ** BUFF_BITS;

	localparam CHANNEL_BITS = 3;

	// inputs:

	input clk, reset;

	// channel interface:

	input ch_req;
	input [SIZE-1:0] ch_flit;
	output ch_ack;

	// switch interface:

	wire sw_req;
	wire [CHANNEL_BITS-1:0] sw_chnl;
	wire sw_gnt = 0;

	// buffer interface:

	wire [BUFF_BITS-1:0] buf_addr;
	wire [SIZE-1:0] buf_data = 0;

	// RX instance

	rx #(
		.SIZE(SIZE),
		.BUFF_BITS(BUFF_BITS),
		.MOD_NAME("Packet Sink"),
		.SINK_PACKETS(1)
	) u2 (
		clk,
		reset,
		ch_req,
		ch_flit,
		ch_ack,
		sw_req,
		sw_chnl,
		sw_gnt,
		buf_addr,
		buf_data
	);

endmodule

`endif
