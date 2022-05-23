////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    wbuart_wrap                                                //
// Project Name:   rvj1-caravel-soc                                           //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    Wraps the wbuart module.                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module	wbuart_wrap #(
		parameter [30:0] INITIAL_SETUP = 31'd25,
        parameter BASE_ADDR = 32'h3001_0000   // This is in a seperate address space to that of Caravel
	) (
		`ifdef USE_POWER_PINS
  		inout vccd1,	// User area 1 1.8V supply
        inout vssd1,	// User area 1 digital ground
		`endif
		
		input	wire		clk_i, 
		input   wire		rst_i,

		// Wishbone inputs
		input	wire		wbs_cyc_i,
		input	wire		wbs_stb_i, 
		input   wire		wbs_we_i,
		input	wire [31:0]	wbs_adr_i,
		input	wire [31:0]	wbs_dat_i,
		input	wire [3:0]	wbs_sel_i,
		output	wire		wbs_ack_o,
		output	wire [31:0]	wbs_dat_o,
		
		input	wire		uart_rx_i,
		output	wire		uart_tx_o
	);
    localparam ADDR_WIDTH = 8;
	localparam ADDR_LO_MASK = (1 << ADDR_WIDTH) - 1;
    localparam ADDR_HI_MASK = 32'hffff_ffff - ADDR_LO_MASK;

    wire wb_cyc, wb_stb;

    assign wb_cyc = wbs_cyc_i & ((wbs_adr_i & ADDR_HI_MASK) == BASE_ADDR);
    assign wb_stb = wbs_stb_i & ((wbs_adr_i & ADDR_HI_MASK) == BASE_ADDR);

	wbuart #(.INITIAL_SETUP(INITIAL_SETUP),
	         .HARDWARE_FLOW_CONTROL_PRESENT(1'b0)) wbuart_inst (.i_clk     (clk_i),
                                                                .i_reset   (rst_i),

                                                                .i_wb_cyc  (wb_cyc),
                                                                .i_wb_stb  (wb_stb),
                                                                .i_wb_we   (wbs_we_i),
                                                                .i_wb_addr (wbs_adr_i[3:2]),
                                                                .i_wb_data (wbs_dat_i),
                                                                .i_wb_sel  (wbs_sel_i),
                                                                .o_wb_stall(),
                                                                .o_wb_ack  (wbs_ack_o),
                                                                .o_wb_data (wbs_dat_o),

                                                                .i_uart_rx (uart_rx_i),
                                                                .o_uart_tx (uart_tx_o),

                                                                .i_cts_n   (1'b0),
                                                                .o_rts_n   (),

																 // Use polling mode
                                                                .o_uart_rx_int (),
                                                                .o_uart_tx_int (),
                                                                .o_uart_rxfifo_int (),
                                                                .o_uart_txfifo_int ());

endmodule
