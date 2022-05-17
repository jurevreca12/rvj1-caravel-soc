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
module rvj1_caravel_soc #(
    parameter JEDRO_1_BOOT_ADDR=32'h3000_0000
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    input wb_clk_i,

    output [31:0] imem_addr,
    input  [31:0] imem_rdata,
    
    output [3:0]  dram_we,
    output        dram_stb,
    output [31:0] dram_addr,
    output [31:0] dram_wdata,
    input  [31:0] dram_rdata,
    input         dram_ack,
    input         dram_err,

    input         jedro_1_rstn
);


    jedro_1_top #(.JEDRO_1_BOOT_ADDR(32'h3000_0000)) jedro_1_inst (.clk_i        (wb_clk_i),
                                                                   .rstn_i       (jedro_1_rstn),
                                                                   
                                                                   .iram_addr    (imem_addr),
                                                                   .iram_rdata   (imem_rdata),

                                                                   .dram_we      (dram_we),
                                                                   .dram_stb     (dram_stb),
                                                                   .dram_addr    (dram_addr),
                                                                   .dram_wdata   (dram_wdata),
                                                                   .dram_rdata   (dram_rdata),
                                                                   .dram_ack     (dram_ack),
                                                                   .dram_err     (dram_err));

endmodule

`default_nettype wire
