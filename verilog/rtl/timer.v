////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    timer                                                      //
// Project Name:   rvj1-caravel-soc                                           //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    A simple wishbone timer.                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module	timer #(
        parameter BASE_ADDR = 32'h3002_0000   // This is in a seperate address space to that of Caravel
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
		output	reg		    wbs_ack_o,
		output	reg  [31:0]	wbs_dat_o,

		output  wire [31:0] time_debug_o	
	);
    localparam ADDR_WIDTH = 1;
	localparam ADDR_LO_MASK = (1 << ADDR_WIDTH) - 1;
    localparam ADDR_HI_MASK = 32'hffff_ffff - ADDR_LO_MASK;

    wire wb_cyc, wb_stb;
	reg [32-1:0] time_ff;

	// WISHBONE READING LOGIC
    assign wb_cyc = wbs_cyc_i & ((wbs_adr_i & ADDR_HI_MASK) == BASE_ADDR);
    assign wb_stb = wbs_stb_i & ((wbs_adr_i & ADDR_HI_MASK) == BASE_ADDR);
	always @(posedge clk_i) begin
		if (rst_i) begin
			wbs_ack_o <= 1'b0;
			wbs_dat_o <= 32'b0;
		end
		else if (wb_cyc && wb_stb && wbs_we_i && ~wbs_ack_o) begin
			wbs_ack_o <= 1'b1;
		end
		else if (wb_cyc && wb_stb && ~wbs_we_i && ~wbs_ack_o) begin
			wbs_ack_o <= 1'b1;
			wbs_dat_o <= time_ff;	
		end
		else begin
			wbs_ack_o <= 1'b0;
		end
	end

	// TIMER LOGIC
	always @(posedge clk_i) begin
		if (rst_i) 
			time_ff <= 32'b0;
		else begin
			if (wb_cyc && wb_stb && wbs_we_i && ~wbs_ack_o) begin
				time_ff <= wbs_dat_i;
			end
			else begin
				time_ff <= time_ff + 1;
			end
		end
	end

	assign time_debug_o = time_ff;
endmodule
