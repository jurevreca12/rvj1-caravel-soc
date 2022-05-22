// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);
    ///////////////////////////////////////////
    // LOCAL PARAMS
    ///////////////////////////////////////////
    localparam IRAM_BASE_ADDR        = 32'h3000_0000;
    localparam IRAM_ADDR_WIDTH_BYTES = $clog2(2048);
    localparam IRAM_ADDR_WIDTH_WORDS = IRAM_ADDR_WIDTH_BYTES - 2;

    localparam DRAM_BASE_ADDR        = 32'h3000_4000;
    localparam DRAM_ADDR_WIDTH_BYTES = $clog2(2048);
    localparam DRAM_ADDR_WIDTH_WORDS = DRAM_ADDR_WIDTH_BYTES - 2;

    ///////////////////////////////////////////
    // SIGNAL DEFINITIONS
    ///////////////////////////////////////////
    wire [31:0]  cpu2imux_rdata;
    wire [31:0]  cpu2imux_addr;

    wire [3:0]   cpu2dmux_we;
    wire         cpu2dmux_stb;
    wire         cpu2dmux_ack;
    wire         cpu2dmux_err;
    wire [31:0]  cpu2dmux_addr;
    wire [31:0]  cpu2dmux_wdata;
    wire [31:0]  cpu2dmux_rdata;

    wire iram_clk0, iram_csb0, iram_web0;
    wire [3:0] iram_wmask0;
    wire [IRAM_ADDR_WIDTH_WORDS-1:0] iram_addr0;
    wire [31:0] iram_din0, iram_dout0;

    wire dram_clk0, dram_csb0, dram_web0;
    wire [3:0]  dram_wmask0;
    wire [DRAM_ADDR_WIDTH_WORDS-1:0] dram_addr0;
    wire [31:0] dram_din0, dram_dout0;
    

    wire         wbs0_stb;
    wire         wbs0_cyc;
    wire         wbs0_we;
    wire [3:0]   wbs0_sel;
    wire [31:0]  wbs0_dat_toram;
    wire [31:0]  wbs0_adr;
    wire         wbs0_ack;
    wire [31:0]  wbs0_dat_fromram;

    wire         wbs1_stb;
    wire         wbs1_cyc;
    wire         wbs1_we;
    wire [3:0]   wbs1_sel;
    wire [31:0]  wbs1_dat_toram;
    wire [31:0]  wbs1_adr;
    wire         wbs1_ack;
    wire [31:0]  wbs1_dat_fromram;

    wire         wbs2_stb;
    wire         wbs2_cyc;
    wire         wbs2_we;
    wire [3:0]   wbs2_sel;
    wire [31:0]  wbs2_dat_towb;
    wire [31:0]  wbs2_adr;
    wire         wbs2_ack;
    wire [31:0]  wbs2_dat_fromwb;
	
	wire		 wb_uart_clk;
	wire		 wb_uart_rst;
    wire         wb_uart_stb;
    wire         wb_uart_cyc;
    wire         wb_uart_we;
    wire [3:0]   wb_uart_sel;
    wire [31:0]  wb_uart_dat_tocpu;
    wire [31:0]  wb_uart_dat_fromcpu;
    wire [31:0]  wb_uart_adr;
    wire         wb_uart_ack;

    ///////////////////////////////////////////
    // System on chip 
    ///////////////////////////////////////////
    wishbone_mux #(.BASE_ADDR_0(IRAM_BASE_ADDR),
                   .ADDR_WIDTH_0(IRAM_ADDR_WIDTH_BYTES),
                   .BASE_ADDR_1(DRAM_BASE_ADDR),
                   .ADDR_WIDTH_1(DRAM_ADDR_WIDTH_BYTES)) wishbone_mux_inst (
						`ifdef USE_POWER_PINS
							.vccd1(vccd1),	// User area 1 1.8V power
							.vssd1(vssd1),	// User area 1 digital ground
						`endif

                            .wbs_stb_i (wbs_stb_i),
                            .wbs_cyc_i (wbs_cyc_i),
                            .wbs_we_i  (wbs_we_i),
                            .wbs_sel_i (wbs_sel_i),
                            .wbs_dat_i (wbs_dat_i),
                            .wbs_adr_i (wbs_adr_i),
                            .wbs_ack_o (wbs_ack_o),
                            .wbs_dat_o (wbs_dat_o),

                            .wbs0_stb_o (wbs0_stb),
                            .wbs0_cyc_o (wbs0_cyc),
                            .wbs0_we_o  (wbs0_we),
                            .wbs0_sel_o (wbs0_sel),
                            .wbs0_dat_o (wbs0_dat_toram),
                            .wbs0_adr_o (wbs0_adr),
                            .wbs0_ack_i (wbs0_ack),
                            .wbs0_dat_i (wbs0_dat_fromram),

                            .wbs1_stb_o (wbs1_stb),
                            .wbs1_cyc_o (wbs1_cyc),
                            .wbs1_we_o  (wbs1_we),
                            .wbs1_sel_o (wbs1_sel),
                            .wbs1_dat_o (wbs1_dat_toram),
                            .wbs1_adr_o (wbs1_adr),
                            .wbs1_ack_i (wbs1_ack),
                            .wbs1_dat_i (wbs1_dat_fromram),

                            .wbs2_stb_o (),
                            .wbs2_cyc_o (),
                            .wbs2_we_o  (),
                            .wbs2_sel_o (),
                            .wbs2_dat_o (),
                            .wbs2_adr_o (),
                            .wbs2_ack_i (1'b0),
                            .wbs2_dat_i (0));
                                                         

    sky130_sram_2kbyte_1rw1r_32x512_8 iram_inst (
					`ifdef USE_POWER_PINS
					   	.vccd1(vccd1),	// User area 1 1.8V power
						.vssd1(vssd1),	// User area 1 digital ground
					`endif

    					.clk0   (iram_clk0),
                        .csb0   (iram_csb0),
                        .web0   (iram_web0),
                        .wmask0 (iram_wmask0),
                        .addr0  (iram_addr0),
                        .din0   (iram_din0),
                        .dout0  (iram_dout0));
                                                 
    instr_ram_mux #(.RAM_ADDR_WIDTH_WORDS(IRAM_ADDR_WIDTH_WORDS),
                    .BASE_ADDR(IRAM_BASE_ADDR)) iram_mux_inst (
							`ifdef USE_POWER_PINS
								.vccd1(vccd1),	// User area 1 1.8V power
								.vssd1(vssd1),	// User area 1 digital ground
							`endif

                    			.sel_wb      (la_data_in[0]),
                                                
                                .rdata       (cpu2imux_rdata),
                                .addr        (cpu2imux_addr),

                                .wb_clk_i    (wb_clk_i),
                                .wb_rst_i    (wb_rst_i),
                                .wbs_stb_i   (wbs0_stb),
                                .wbs_cyc_i   (wbs0_cyc),
                                .wbs_we_i    (wbs0_we),
                                .wbs_sel_i   (wbs0_sel),
                                .wbs_dat_i   (wbs0_dat_toram),
                                .wbs_adr_i   (wbs0_adr),
                                .wbs_ack_o   (wbs0_ack),
                                .wbs_dat_o   (wbs0_dat_fromram),

                                .ram_clk0    (iram_clk0),
                                .ram_csb0    (iram_csb0),
                                .ram_web0    (iram_web0),
                                .ram_wmask0  (iram_wmask0),
                                .ram_addr0   (iram_addr0),
                                .ram_din0    (iram_din0),
                                .ram_dout0   (iram_dout0));
                                             


	rvj1_caravel_soc #(.JEDRO_1_BOOT_ADDR(IRAM_BASE_ADDR)) rvj1_core (
		`ifdef USE_POWER_PINS
			.vccd1(vccd1),	// User area 1 1.8V power
			.vssd1(vssd1),	// User area 1 digital ground
		`endif
		
		    .wb_clk_i       (wb_clk_i),
		    
		    .imem_addr      (cpu2imux_addr),
		    .imem_rdata     (cpu2imux_rdata),
		
		    .dram_we        (cpu2dmux_we),
		    .dram_stb       (cpu2dmux_stb),
		    .dram_addr      (cpu2dmux_addr),
		    .dram_wdata     (cpu2dmux_wdata),
		    .dram_rdata     (cpu2dmux_rdata),
		    .dram_ack       (cpu2dmux_ack),
		    .dram_err       (cpu2dmux_err),
		
		    .jedro_1_rstn   (la_data_in[1])
		);



    data_ram_mux #(.RAM_ADDR_WIDTH_WORDS(DRAM_ADDR_WIDTH_WORDS),
                   .BASE_ADDR(DRAM_BASE_ADDR)) dram_mux_inst(
							`ifdef USE_POWER_PINS
								.vccd1(vccd1),	// User area 1 1.8V power
								.vssd1(vssd1),	// User area 1 digital ground
							`endif

                   				.sel_wb(la_data_in[0]),
                                                            
                                .rdata       (cpu2dmux_rdata),
                                .ack         (cpu2dmux_ack),
                                .err         (cpu2dmux_err),
                                .we          (cpu2dmux_we),
                                .stb         (cpu2dmux_stb),
                                .addr        (cpu2dmux_addr),
                                .wdata       (cpu2dmux_wdata),

                                .wb_clk_i    (wb_clk_i),
                                .wb_rst_i    (wb_rst_i),
                                .wbs_stb_i   (wbs1_stb),
                                .wbs_cyc_i   (wbs1_cyc),
                                .wbs_we_i    (wbs1_we),
                                .wbs_sel_i   (wbs1_sel),
                                .wbs_dat_i   (wbs1_dat_toram),
                                .wbs_adr_i   (wbs1_adr),
                                .wbs_ack_o   (wbs1_ack),
                                .wbs_dat_o   (wbs1_dat_fromram),

                                .ram_clk0    (dram_clk0),
                                .ram_csb0    (dram_csb0),
                                .ram_web0    (dram_web0),
                                .ram_wmask0  (dram_wmask0),
                                .ram_addr0   (dram_addr0),
                                .ram_din0    (dram_din0),
                                .ram_dout0   (dram_dout0),

								.wbm_clk_o   (wb_uart_clk),
								.wbm_rst_o   (wb_uart_rst),
								.wbm_stb_o   (wb_uart_stb),
								.wbm_cyc_o   (wb_uart_cyc),
								.wbm_we_o    (wb_uart_we),
								.wbm_sel_o   (wb_uart_sel),
								.wbm_dat_o   (wb_uart_dat_fromcpu),
								.wbm_adr_o   (wb_uart_adr),
								.wbm_ack_i   (wb_uart_ack),
								.wbm_dat_i   (wb_uart_dat_tocpu));
 
    sky130_sram_2kbyte_1rw1r_32x512_8  dram_inst (
						`ifdef USE_POWER_PINS
							.vccd1(vccd1),	// User area 1 1.8V power
							.vssd1(vssd1),	// User area 1 digital ground
						`endif

    						.clk0   (dram_clk0),
                            .csb0   (dram_csb0),
                            .web0   (dram_web0),
                            .wmask0 (dram_wmask0),
                            .addr0  (dram_addr0),
                            .din0   (dram_din0),
                            .dout0  (dram_dout0));



	wbuart_wrap uart_inst (
						`ifdef USE_POWER_PINS
						    .vccd1(vccd1),	// User area 1 1.8V power
						    .vssd1(vssd1),	// User area 1 digital ground
						`endif
						   	.clk_i     (wb_clk_i),
							.rstn_i    (~wb_rst_i),
							.wbs_cyc_i (wb_uart_cyc),
							.wbs_stb_i (wb_uart_stb),
							.wbs_we_i  (wb_uart_we),
							.wbs_adr_i (wb_uart_adr),
							.wbs_dat_i (wb_uart_dat_fromcpu),
							.wbs_sel_i (wb_uart_sel),
							.wbs_ack_o (wb_uart_ack),
							.wbs_dat_o (wb_uart_dat_tocpu),
							
							.uart_rx_i (1'b0),
							.uart_tx_o ()			
				);


endmodule	// user_project_wrapper

`default_nettype wire
