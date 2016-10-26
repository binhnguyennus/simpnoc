`ifndef SIZE
	`define SIZE 8
`endif

`ifndef _inc_rx_
	`define _inc_rx_
	`include "rx.v"
`endif

module serial_moody_sink (clk, reset, channel_busy, serial_in);

	parameter id = -1;

	parameter hospitality = 0; // min 0, max 255

	input clk, reset, serial_in;

	output channel_busy;

	wire [`SIZE-1:0] data;

	moody_sink #(id, hospitality) s1 (.clk(clk), .reset(reset), .data(data), .req(req), .busy(busy));

	rx rx1 (.clk(clk), .reset(reset), .valid(req), .channel_busy(channel_busy), .item_read(!busy), .serial_in(serial_in), .parallel_out(data) );

endmodule


module moody_sink (clk, reset, data, req, busy);

	parameter id = -1;

	parameter hospitality = 0; // min 0, max 255

	input clk, reset, req;

	output busy;

	input [`SIZE-1:0] data;

	reg [`SIZE-1:0] register;

	reg busy;

	reg [7:0] rand;

	always @(posedge clk or posedge reset) begin

		if (reset) begin
			register <= 0;
			busy <= 1;
			rand <= 0;
		end else begin
			rand <= $random;
			if (req & !busy) begin
				register <= data;
				if (id != -1) $display ("sink %d rx  : %d ", id, data);
			end
			busy <= (rand >= hospitality);
		end

	end

endmodule
