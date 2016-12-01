`ifndef _inc_packet_source_
`define _inc_packet_source_

`include "debug_tasks.v"

module packet_source (clk, reset, req, ack, data);

	// parameters

	parameter ID = 0;
	parameter FLITS = 8;
	parameter SIZE = 8;
	parameter SEED = 1;

	// debugging modules

	DebugTasks DT();

	// inputs and output

	input clk, reset, ack;
	output reg req;
	output reg [SIZE-1:0] data;

	reg [SIZE-1:0] MEM_BUF [FLITS-1:0];
	reg [7:0] flit_counter;
	reg ack_old;
	reg busy;
	wire ack_received = ack ^ ack_old;

	integer seed = SEED;

	integer i;

	always @(posedge clk or posedge reset) begin

		if (reset) begin

			data <= 0;
			req <= 0;
			flit_counter <= 0;
			ack_old <= 0;
			busy <= 0;
			MEM_BUF[0] = $urandom(seed); // dummy to initialize rng
			for (i=0; i<FLITS; i=i+1) begin
				MEM_BUF[i] = $urandom(seed);
				MEM_BUF[i][SIZE-1] = 0; // mark flit as body
			end
			MEM_BUF[0][SIZE-1] = 1; // mark first flit as head

		end else begin

			ack_old <= ack;

			if (!busy && flit_counter<FLITS) begin

				if (flit_counter == 0) begin
					DT.printPrefix("Packet Source", ID);
					$display("initiated packet <0x%h>", {
						MEM_BUF[7],
						MEM_BUF[6],
						MEM_BUF[5],
						MEM_BUF[4],
						MEM_BUF[3],
						MEM_BUF[2],
						MEM_BUF[1],
						MEM_BUF[0]
					});
				end

				data <= MEM_BUF[flit_counter];
				req <= ~req;
				flit_counter <= flit_counter + 1;
				busy <= 1;
				DT.printPrefix("Packet Source", ID);
				$display("sending <0x%h>", MEM_BUF[flit_counter]);

			end else if (busy & ack_received) begin

				DT.printPrefix("Packet Source", ID);
				$display("received ack");
				busy <= 0;

			end

		end

	end

endmodule

`endif
