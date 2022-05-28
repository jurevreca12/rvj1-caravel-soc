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
`include "rvj1_defines.v"

`default_nettype none
module rvj1_caravel_soc #(
    parameter JEDRO_1_BOOT_ADDR = `JEDRO_1_BOOT_ADDR,
    parameter IRAM_BASE_ADDR = `IRAM_BASE_ADDR,
    parameter IRAM_ADDR_WIDTH_WORDS = `IRAM_ADDR_WIDTH_WORDS,
    parameter DRAM_BASE_ADDR = `DRAM_BASE_ADDR,
    parameter DRAM_ADDR_WIDTH_WORDS = `DRAM_ADDR_WIDTH_WORDS
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    input jedro_1_rstn,
    input sel_wb,


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
    
	output		  wb_uart_clk,
	output		  wb_uart_rst,
    output        wb_uart_stb,
    output        wb_uart_cyc,
    output        wb_uart_we,
    output [3:0]  wb_uart_sel,
    output [31:0] wb_uart_dat_fromcpu,
    output [31:0] wb_uart_adr,
    input         wb_uart_ack,
    input  [31:0] wb_uart_dat_tocpu,
    
    output iram_clk0, 
    output iram_csb0, 
    output iram_web0,
    output [3:0] iram_wmask0,
    output [IRAM_ADDR_WIDTH_WORDS-1:0] iram_addr0,
    output  [31:0] iram_din0, 
    input [31:0] iram_dout0,

    output dram_clk0, 
    output dram_csb0, 
    output dram_web0,
    output [3:0] dram_wmask0,
    output [DRAM_ADDR_WIDTH_WORDS-1:0] dram_addr0,
    output  [31:0] dram_din0, 
    input [31:0] dram_dout0
    
);
    ///////////////////////////////////////////
    // LOCAL PARAMS
    ///////////////////////////////////////////
    localparam IRAM_ADDR_WIDTH_BYTES = IRAM_ADDR_WIDTH_WORDS + 2;
    localparam DRAM_ADDR_WIDTH_BYTES = DRAM_ADDR_WIDTH_WORDS + 2;
    
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
                            
                            
    instr_ram_mux #(.RAM_ADDR_WIDTH_WORDS(IRAM_ADDR_WIDTH_WORDS),
                    .BASE_ADDR(IRAM_BASE_ADDR)) iram_mux_inst (
							`ifdef USE_POWER_PINS
								.vccd1(vccd1),	// User area 1 1.8V power
								.vssd1(vssd1),	// User area 1 digital ground
							`endif

                    			.sel_wb      (sel_wb),
                                                
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

    jedro_1_top #(.JEDRO_1_BOOT_ADDR(32'h3000_0000)) jedro_1_inst (.clk_i        (wb_clk_i),
                                                                   .rstn_i       (jedro_1_rstn),
                                                                   
                                                                   .iram_addr    (cpu2imux_addr),
                                                                   .iram_rdata   (cpu2imux_rdata),

                                                                   .dram_we      (cpu2dmux_we),
                                                                   .dram_stb     (cpu2dmux_stb),
                                                                   .dram_addr    (cpu2dmux_addr),
                                                                   .dram_wdata   (cpu2dmux_wdata),
                                                                   .dram_rdata   (cpu2dmux_rdata),
                                                                   .dram_ack     (cpu2dmux_ack),
                                                                   .dram_err     (cpu2dmux_err));
                                                                   
                                                                   
	data_ram_mux #(.RAM_ADDR_WIDTH_WORDS(DRAM_ADDR_WIDTH_WORDS),
                   .BASE_ADDR(DRAM_BASE_ADDR)) dram_mux_inst(
							`ifdef USE_POWER_PINS
								.vccd1(vccd1),	// User area 1 1.8V power
								.vssd1(vssd1),	// User area 1 digital ground
							`endif

                   				.sel_wb(sel_wb),
                                                            
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

endmodule

`default_nettype wire
