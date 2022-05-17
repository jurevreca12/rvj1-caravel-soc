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
//                                          --|   instr_mem_if                //
//                                        -   |-----                          //
//                |--------|             |    |                               //
//                |  DATA  | openram_if  |    |                               //
//                |   RAM  |-------------|    |                               //
//                |        |             |    |   wishbone if                 //
//                |________|              -   |-----                          //
//                                          --|                               //
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

    output reg  [31:0]                     rdata,
    output reg                             ack,
    output reg                             err,
    input  wire [3:0]                      we,
    input  wire                            stb,
    input  wire [31:0]                     addr,
    input  wire [31:0]                     wdata,

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

    output wire                            ram_clk0,
    output reg                             ram_csb0,   // active low chip select
    output reg                             ram_web0,   // active low write enable
    output reg  [3:0]                      ram_wmask0, // write (byte) mask
    output reg  [RAM_ADDR_WIDTH_WORDS-1:0] ram_addr0,
    output reg  [31:0]                     ram_din0,
    input  wire [31:0]                     ram_dout0
);
    localparam ADDR_LO_MASK = (1 << RAM_ADDR_WIDTH_WORDS) - 1;
    localparam ADDR_HI_MASK = 32'hffff_ffff - ADDR_LO_MASK; 

    wire ram_cs;
    reg  ram_cs_r;
    reg ram_wbs_ack_r;
    reg core_ack;
    
    assign ram_cs = wbs_stb_i && wbs_cyc_i && ((wbs_adr_i & ADDR_HI_MASK) == BASE_ADDR) && !wb_rst_i;
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
    
    assign ram_clk0 = wb_clk_i;


    always @(posedge wb_clk_i) begin
        if (wb_rst_i) core_ack <= 0;
        else          core_ack <= stb;
    end

    always@(*) begin
        if (sel_wb) begin
            ram_csb0   = !ram_cs_r;
            ram_web0   = ~wbs_we_i;
            ram_wmask0 = wbs_sel_i;
            ram_addr0  = wbs_adr_i[RAM_ADDR_WIDTH_WORDS-1:0];
            ram_din0   = wbs_dat_i;
            wbs_dat_o  = ram_dout0;
            wbs_ack_o  = ram_wbs_ack_r && ram_cs;
            rdata = 0; 
            ack   = 0;
            err   = 0;
        end
        else begin
            ram_csb0   = ~stb;  // active low
            ram_web0   = ~(|we);  // active low
            ram_wmask0 = we;  
            ram_addr0  = addr[RAM_ADDR_WIDTH_WORDS+2-1:2];
            ram_din0   = wdata;
            rdata      = ram_dout0; 
            ack        = core_ack;
            err        = 0; // TODO add addr checking, that returns err on wrong addr.
        end
    end

endmodule
