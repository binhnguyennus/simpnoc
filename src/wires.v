wire clk, reset;

wire [DESTINATION_BITS-1:0] table_addr [ROUTER_COUNT-1:0];
reg [PORT_BITS-1:0] table_data [ROUTER_COUNT-1:0];

wire [PORT_COUNT-1:0] tx_req [ROUTER_COUNT-1:0];
wire [PORT_COUNT-1:0] tx_ack [ROUTER_COUNT-1:0];
wire [PORT_COUNT*SIZE-1:0] tx_data [ROUTER_COUNT-1:0];

wire [PORT_COUNT-1:0] rx_req [ROUTER_COUNT-1:0];
wire [PORT_COUNT-1:0] rx_ack [ROUTER_COUNT-1:0];
wire [PORT_COUNT*SIZE-1:0] rx_data [ROUTER_COUNT-1:0];

wire snk_req [SINK_COUNT-1:0];
wire snk_ack [SINK_COUNT-1:0];
wire [SIZE-1:0] snk_data [SINK_COUNT-1:0];

wire src_req [SOURCE_COUNT-1:0];
wire src_ack [SOURCE_COUNT-1:0];
wire [SIZE-1:0] src_data [SOURCE_COUNT-1:0];

wire term_tx_req [SOURCE_COUNT-1:0];
wire term_tx_ack [SOURCE_COUNT-1:0];
wire [SIZE-1:0] term_tx_data [SOURCE_COUNT-1:0];

wire term_rx_req [SOURCE_COUNT-1:0];
wire term_rx_ack [SOURCE_COUNT-1:0];
wire [SIZE-1:0] term_rx_data [SOURCE_COUNT-1:0];
