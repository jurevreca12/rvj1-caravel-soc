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
 * rvj1_caravel_soc
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module rvj1_caravel_soc #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
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

    // IRQ
    output [2:0] irq
);
	///////////////////////////////////////////                                                                         
    // LOCAL PARAMS                                                                                                     
    ///////////////////////////////////////////                                                                         
    localparam IRAM_BASE_ADDR        = 32'h3000_0000;                                                                   
    localparam IRAM_ADDR_WIDTH_BYTES = $clog2(2048);                                                                    
    localparam IRAM_ADDR_WIDTH_WORDS = IRAM_ADDR_WIDTH_BYTES - 2;                                                       
                                                                                                                        
    localparam DRAM_BASE_ADDR        = 32'h3000_4000;                                                                   
    localparam DRAM_ADDR_WIDTH_BYTES = $clog2(1024);                                                                    
    localparam DRAM_ADDR_WIDTH_WORDS = DRAM_ADDR_WIDTH_BYTES - 2;                                                       
                                                                                                                        
    ///////////////////////////////////////////                                                                         
    // SIGNAL DEFINITIONS                                                                                               
    ///////////////////////////////////////////   
	wire iram_clk0, iram_csb0, iram_web0;                                                                               
    wire [3:0] iram_wmask0;                                                                                             
    wire [IRAM_ADDR_WIDTH_WORDS-1:0] iram_addr0;                                                                        
    wire [31:0] iram_din0, iram_dout0;

	assign iram_clk0 = wb_clk_i;

	instr_ram_mux #(.RAM_ADDR_WIDTH_WORDS(IRAM_ADDR_WIDTH_WORDS),                                                       
                    .BASE_ADDR(IRAM_BASE_ADDR)) iram_mux_inst (                                                         
                            `ifdef USE_POWER_PINS                                                                       
                                .vccd1(vccd1),  // User area 1 1.8V power                                               
                                .vssd1(vssd1),  // User area 1 digital ground                                           
                            `endif                                                                                      
                                .sel_wb      (la_data_in[0]), 
								
								 // CPU IF
                                .rdata       (),  
                                .addr        (32'b0),
 
                                .wb_clk_i    (wb_clk_i), 
                                .wb_rst_i    (wb_rst_i),
                                .wbs_stb_i   (wbs_stb_i),
                                .wbs_cyc_i   (wbs_cyc_i),
                                .wbs_we_i    (wbs_we_i),
                                .wbs_sel_i   (wbs_sel_i),
                                .wbs_dat_i   (wbs_dat_i),
                                .wbs_adr_i   (wbs_adr_i),
                                .wbs_ack_o   (wbs_ack_o),
                                .wbs_dat_o   (wbs_dat_o),
                                                                                          
                                .ram_csb0    (iram_csb0),
                                .ram_web0    (iram_web0),
                                .ram_wmask0  (iram_wmask0),
                                .ram_addr0   (iram_addr0),
                                .ram_din0    (iram_din0),
                                .ram_dout0   (iram_dout0));


	sky130_sram_2kbyte_1rw1r_32x512_8 iram_inst (                                                                       
                    `ifdef USE_POWER_PINS                                                                               
                        .vccd1(vccd1),  // User area 1 1.8V power                                                       
                        .vssd1(vssd1),  // User area 1 digital ground                                                   
                    `endif                                                                                                                                                                                              
                        .clk0   (iram_clk0),                                                                     
                        .csb0   (iram_csb0),                                                   
                        .web0   (iram_web0),                                                   
                        .wmask0 (iram_wmask0),                                                 
                        .addr0  (iram_addr0),                                                  
                        .din0   (iram_din0),                                                   
                        .dout0  (iram_dout0));

endmodule

`default_nettype wire
