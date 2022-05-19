////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    data_ram_mux                                               //
// Project Name:   rvj1-caravel-soc                                           //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    A mux for the data RAM. It is interfaced by the            //
//                 riscv-jedro-1 core and a wishbone master.                  //
//                                                                            //
//                                                      					  //
//                                          --|   instr_mem_if                //
//                |--------|              -   |-----                          //
//                |  DATA  | openram_if  |    |                               //
//                |   RAM  |-------------|    |                               //
//                |        |    wbm_if   |    |                               //
//                |________|   |---------|    |   wishbone if                 //
//                             |          -   |-----                          //
//                             |            --|                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module data_ram_mux #(
    parameter RAM_ADDR_WIDTH_WORDS = 8,
    parameter BASE_ADDR = 32'h3000_4000
)
(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif
    input  wire                            sel_wb,

	// Interface to rvj1 core
    output reg  [31:0]                     rdata,
    output reg                             ack,
    output reg                             err,
    input  wire [3:0]                      we,
    input  wire                            stb,
    input  wire [31:0]                     addr,
    input  wire [31:0]                     wdata,

	// Input slave wishbone interface
    input  wire                            wb_clk_i,
    input  wire                            wb_rst_i,
    input  wire                            wbs_stb_i,
    input  wire                            wbs_cyc_i,
    input  wire                            wbs_we_i,
    input  wire [3:0]                      wbs_sel_i,
    input  wire [31:0]                     wbs_dat_i,
    input  wire [31:0]                     wbs_adr_i,
    output reg                             wbs_ack_o,
    output reg  [31:0]                     wbs_dat_o,

	// Output to data ram
    output wire                            ram_clk0,
    output reg                             ram_csb0,   // active low chip select
    output reg                             ram_web0,   // active low write enable
    output reg  [3:0]                      ram_wmask0, // write (byte) mask
    output reg  [RAM_ADDR_WIDTH_WORDS-1:0] ram_addr0,
    output reg  [31:0]                     ram_din0,
    input  wire [31:0]                     ram_dout0,

	// Output to wishbone master
	output wire							   wbm_clk_o,
	output reg							   wbm_rst_o,
	output reg							   wbm_stb_o,
	output reg							   wbm_cyc_o,
	output reg							   wbm_we_o,
	output reg	[3:0]					   wbm_sel_o,
	output reg [31:0]					   wbm_dat_o,
	output reg [31:0]					   wbm_adr_o,
	input wire							   wbm_ack_i,
	input wire [31:0]					   wbm_dat_i
);
	/****************************
	* DEFINITIONS AND CLOCKING
	****************************/
    localparam ADDR_LO_MASK = (1 << RAM_ADDR_WIDTH_WORDS) - 1;
    localparam ADDR_HI_MASK = 32'hffff_ffff - ADDR_LO_MASK; 
    
	wire ram_cs;
    reg ram_cs_r, ram_wbs_ack_r, core_ack;
	reg was_ram;	

    assign ram_clk0 = wb_clk_i;
	assign wbm_clk_o = wb_clk_i;

	/****************************
	* WISHBONE SLAVE - RAM ACKING
	****************************/
    assign ram_cs = sel_wb && wbs_stb_i && wbs_cyc_i && ((wbs_adr_i & ADDR_HI_MASK) == BASE_ADDR) && !wb_rst_i;
    always @(negedge wb_clk_i) begin
        if (wb_rst_i) begin
            ram_cs_r <= 0;
            ram_wbs_ack_r <= 0;
        end
        else begin
            ram_cs_r <= !ram_cs_r && ram_cs;
            ram_wbs_ack_r <= ram_cs_r;
        end
    end
    
    always @(posedge wb_clk_i) begin
        if (wb_rst_i) core_ack <= 0;
        else          core_ack <= stb && is_ram;
    end

	/****************************
	* IS CORE WRITE TO RAM LOGIC
	****************************/
	assign is_ram = (addr & ADDR_HI_MASK) == BASE_ADDR;
	always@(posedge wb_clk_i) begin
		if (wb_rst_i) was_ram <= 0;
		else		  was_ram <= is_ram;
	end

	/****************************
	* COMBINATIONAL LOGIC
	****************************/
    always@(*) begin
		ram_csb0 = 1'b1; // it is active low
		ram_web0 = 1'b1; // also active low
		ram_wmask0 = 0;
		ram_addr0 = 0;
		ram_din0 = 0;
		wbm_stb_o = 0;
		wbm_cyc_o = 0;
		wbm_we_o = 0;
		wbm_sel_o = 0;
		wbm_dat_o = 0;
		wbm_adr_o = 0;
		rdata = 0;
		ack = 0;
		err = 0;
		wbs_ack_o = 0;
		wbs_dat_o = 0;
        if (sel_wb) begin
        	ram_csb0   = !ram_cs_r;
            ram_web0   = ~wbs_we_i;
            ram_wmask0 = wbs_sel_i;
            ram_addr0  = wbs_adr_i[RAM_ADDR_WIDTH_WORDS-1:0];
            ram_din0   = wbs_dat_i;
            wbs_dat_o  = ram_dout0;
            wbs_ack_o  = ram_wbs_ack_r && ram_cs;
        end
        else begin
        	ram_csb0   = (~stb) && is_ram;  // active low
        	ram_web0   = (~(|we)) && is_ram;  // active low
        	ram_wmask0 = we && is_ram;  
        	ram_addr0  = addr[RAM_ADDR_WIDTH_WORDS+2-1:2];
        	ram_din0   = wdata;

			wbm_stb_o  = stb;
			wbm_cyc_o  = stb;
			wbm_we_o   = |we;
			wbm_sel_o  = 4'b1111; // Currently LSU only supports reading words
			wbm_dat_o  = wdata;
			wbm_adr_o  = addr;
        	
        	ack        = core_ack | wbm_ack_i; // core_ack is generated only when writing to ram
			err		   = 0;  // TODO
			if (was_ram) rdata = ram_dout0; // This assumes 1 cycle delay from all slave devices
			else		 rdata = wbm_dat_i;  
        end
    end

endmodule
