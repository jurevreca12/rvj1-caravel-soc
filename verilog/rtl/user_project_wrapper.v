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

    wire iram_clk0, iram_csb0, iram_web0;
    wire [3:0] iram_wmask0;
    wire [IRAM_ADDR_WIDTH_WORDS-1:0] iram_addr0;
    wire [31:0] iram_din0, iram_dout0;

    wire dram_clk0, dram_csb0, dram_web0;
    wire [3:0]  dram_wmask0;
    wire [DRAM_ADDR_WIDTH_WORDS-1:0] dram_addr0;
    wire [31:0] dram_din0, dram_dout0;
    
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


	rvj1_caravel_soc #(.JEDRO_1_BOOT_ADDR(IRAM_BASE_ADDR),
					   .IRAM_BASE_ADDR(IRAM_BASE_ADDR),
					   .IRAM_ADDR_WIDTH_WORDS(IRAM_ADDR_WIDTH_WORDS),	
					   .DRAM_BASE_ADDR(DRAM_BASE_ADDR),
					   .DRAM_ADDR_WIDTH_WORDS(DRAM_ADDR_WIDTH_WORDS)) rvj1_soc (
		`ifdef USE_POWER_PINS
			.vccd1(vccd1),	// User area 1 1.8V power
			.vssd1(vssd1),	// User area 1 digital ground
		`endif
		    .jedro_1_rstn   (la_data_in[1]),
		    .sel_wb			(la_data_in[0]),
		    
		    .wb_clk_i       (wb_clk_i),
		    .wb_rst_i		(wb_rst_i),
		    .wbs_stb_i		(wbs_stb_i),
		    .wbs_cyc_i		(wbs_cyc_i),
		    .wbs_we_i		(wbs_we_i),
		    .wbs_sel_i		(wbs_sel_i),
		    .wbs_dat_i		(wbs_dat_i),
		    .wbs_adr_i		(wbs_adr_i),
		    .wbs_ack_o		(wbs_ack_o),
		    .wbs_dat_o		(wbs_dat_o),
		    
		    .wb_uart_clk		 (wb_uart_clk),
		    .wb_uart_rst		 (wb_uart_rst),
		    .wb_uart_stb		 (wb_uart_stb),
		    .wb_uart_cyc		 (wb_uart_cyc),
		    .wb_uart_we			 (wb_uart_we),
		    .wb_uart_sel		 (wb_uart_sel),
		    .wb_uart_dat_fromcpu (wb_uart_dat_fromcpu),
		    .wb_uart_adr		 (wb_uart_adr),
		    .wb_uart_ack		 (wb_uart_ack),
		    .wb_uart_dat_tocpu	 (wb_uart_dat_tocpu),
		    
		    .iram_clk0		(iram_clk0),
		    .iram_csb0		(iram_csb0),
			.iram_web0		(iram_web0),
			.iram_wmask0	(iram_wmask0),
			.iram_addr0		(iram_addr0),
			.iram_din0		(iram_din0),
			.iram_dout0		(iram_dout0),
			
			.dram_clk0		(dram_clk0),
			.dram_csb0		(dram_csb0),
			.dram_web0		(dram_web0),
			.dram_wmask0	(dram_wmask0),
			.dram_addr0		(dram_addr0),
			.dram_din0		(dram_din0),
			.dram_dout0		(dram_dout0)
		);
 
 
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
							.rst_i     (wb_rst_i),
							.wbs_cyc_i (wb_uart_cyc),
							.wbs_stb_i (wb_uart_stb),
							.wbs_we_i  (wb_uart_we),
							.wbs_adr_i (wb_uart_adr),
							.wbs_dat_i (wb_uart_dat_fromcpu),
							.wbs_sel_i (wb_uart_sel),
							.wbs_ack_o (wb_uart_ack),
							.wbs_dat_o (wb_uart_dat_tocpu),
							
							.uart_rx_i (io_in[9]),
							.uart_tx_o (io_out[10])			
				);


endmodule	// user_project_wrapper

`default_nettype wire
