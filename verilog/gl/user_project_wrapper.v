module user_project_wrapper (user_clock2,
    vccd1,
    vccd2,
    vdda1,
    vdda2,
    vssa1,
    vssa2,
    vssd1,
    vssd2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input vccd1;
 input vccd2;
 input vdda1;
 input vdda2;
 input vssa1;
 input vssa2;
 input vssd1;
 input vssd2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;

 wire \dram_addr0[0] ;
 wire \dram_addr0[1] ;
 wire \dram_addr0[2] ;
 wire \dram_addr0[3] ;
 wire \dram_addr0[4] ;
 wire \dram_addr0[5] ;
 wire \dram_addr0[6] ;
 wire \dram_addr0[7] ;
 wire \dram_addr0[8] ;
 wire dram_clk0;
 wire dram_csb0;
 wire \dram_din0[0] ;
 wire \dram_din0[10] ;
 wire \dram_din0[11] ;
 wire \dram_din0[12] ;
 wire \dram_din0[13] ;
 wire \dram_din0[14] ;
 wire \dram_din0[15] ;
 wire \dram_din0[16] ;
 wire \dram_din0[17] ;
 wire \dram_din0[18] ;
 wire \dram_din0[19] ;
 wire \dram_din0[1] ;
 wire \dram_din0[20] ;
 wire \dram_din0[21] ;
 wire \dram_din0[22] ;
 wire \dram_din0[23] ;
 wire \dram_din0[24] ;
 wire \dram_din0[25] ;
 wire \dram_din0[26] ;
 wire \dram_din0[27] ;
 wire \dram_din0[28] ;
 wire \dram_din0[29] ;
 wire \dram_din0[2] ;
 wire \dram_din0[30] ;
 wire \dram_din0[31] ;
 wire \dram_din0[3] ;
 wire \dram_din0[4] ;
 wire \dram_din0[5] ;
 wire \dram_din0[6] ;
 wire \dram_din0[7] ;
 wire \dram_din0[8] ;
 wire \dram_din0[9] ;
 wire \dram_dout0[0] ;
 wire \dram_dout0[10] ;
 wire \dram_dout0[11] ;
 wire \dram_dout0[12] ;
 wire \dram_dout0[13] ;
 wire \dram_dout0[14] ;
 wire \dram_dout0[15] ;
 wire \dram_dout0[16] ;
 wire \dram_dout0[17] ;
 wire \dram_dout0[18] ;
 wire \dram_dout0[19] ;
 wire \dram_dout0[1] ;
 wire \dram_dout0[20] ;
 wire \dram_dout0[21] ;
 wire \dram_dout0[22] ;
 wire \dram_dout0[23] ;
 wire \dram_dout0[24] ;
 wire \dram_dout0[25] ;
 wire \dram_dout0[26] ;
 wire \dram_dout0[27] ;
 wire \dram_dout0[28] ;
 wire \dram_dout0[29] ;
 wire \dram_dout0[2] ;
 wire \dram_dout0[30] ;
 wire \dram_dout0[31] ;
 wire \dram_dout0[3] ;
 wire \dram_dout0[4] ;
 wire \dram_dout0[5] ;
 wire \dram_dout0[6] ;
 wire \dram_dout0[7] ;
 wire \dram_dout0[8] ;
 wire \dram_dout0[9] ;
 wire dram_web0;
 wire \dram_wmask0[0] ;
 wire \dram_wmask0[1] ;
 wire \dram_wmask0[2] ;
 wire \dram_wmask0[3] ;
 wire \iram_addr0[0] ;
 wire \iram_addr0[1] ;
 wire \iram_addr0[2] ;
 wire \iram_addr0[3] ;
 wire \iram_addr0[4] ;
 wire \iram_addr0[5] ;
 wire \iram_addr0[6] ;
 wire \iram_addr0[7] ;
 wire \iram_addr0[8] ;
 wire iram_clk0;
 wire iram_csb0;
 wire \iram_din0[0] ;
 wire \iram_din0[10] ;
 wire \iram_din0[11] ;
 wire \iram_din0[12] ;
 wire \iram_din0[13] ;
 wire \iram_din0[14] ;
 wire \iram_din0[15] ;
 wire \iram_din0[16] ;
 wire \iram_din0[17] ;
 wire \iram_din0[18] ;
 wire \iram_din0[19] ;
 wire \iram_din0[1] ;
 wire \iram_din0[20] ;
 wire \iram_din0[21] ;
 wire \iram_din0[22] ;
 wire \iram_din0[23] ;
 wire \iram_din0[24] ;
 wire \iram_din0[25] ;
 wire \iram_din0[26] ;
 wire \iram_din0[27] ;
 wire \iram_din0[28] ;
 wire \iram_din0[29] ;
 wire \iram_din0[2] ;
 wire \iram_din0[30] ;
 wire \iram_din0[31] ;
 wire \iram_din0[3] ;
 wire \iram_din0[4] ;
 wire \iram_din0[5] ;
 wire \iram_din0[6] ;
 wire \iram_din0[7] ;
 wire \iram_din0[8] ;
 wire \iram_din0[9] ;
 wire \iram_dout0[0] ;
 wire \iram_dout0[10] ;
 wire \iram_dout0[11] ;
 wire \iram_dout0[12] ;
 wire \iram_dout0[13] ;
 wire \iram_dout0[14] ;
 wire \iram_dout0[15] ;
 wire \iram_dout0[16] ;
 wire \iram_dout0[17] ;
 wire \iram_dout0[18] ;
 wire \iram_dout0[19] ;
 wire \iram_dout0[1] ;
 wire \iram_dout0[20] ;
 wire \iram_dout0[21] ;
 wire \iram_dout0[22] ;
 wire \iram_dout0[23] ;
 wire \iram_dout0[24] ;
 wire \iram_dout0[25] ;
 wire \iram_dout0[26] ;
 wire \iram_dout0[27] ;
 wire \iram_dout0[28] ;
 wire \iram_dout0[29] ;
 wire \iram_dout0[2] ;
 wire \iram_dout0[30] ;
 wire \iram_dout0[31] ;
 wire \iram_dout0[3] ;
 wire \iram_dout0[4] ;
 wire \iram_dout0[5] ;
 wire \iram_dout0[6] ;
 wire \iram_dout0[7] ;
 wire \iram_dout0[8] ;
 wire \iram_dout0[9] ;
 wire iram_web0;
 wire \iram_wmask0[0] ;
 wire \iram_wmask0[1] ;
 wire \iram_wmask0[2] ;
 wire \iram_wmask0[3] ;
 wire wb_uart_ack;
 wire \wb_uart_adr[0] ;
 wire \wb_uart_adr[10] ;
 wire \wb_uart_adr[11] ;
 wire \wb_uart_adr[12] ;
 wire \wb_uart_adr[13] ;
 wire \wb_uart_adr[14] ;
 wire \wb_uart_adr[15] ;
 wire \wb_uart_adr[16] ;
 wire \wb_uart_adr[17] ;
 wire \wb_uart_adr[18] ;
 wire \wb_uart_adr[19] ;
 wire \wb_uart_adr[1] ;
 wire \wb_uart_adr[20] ;
 wire \wb_uart_adr[21] ;
 wire \wb_uart_adr[22] ;
 wire \wb_uart_adr[23] ;
 wire \wb_uart_adr[24] ;
 wire \wb_uart_adr[25] ;
 wire \wb_uart_adr[26] ;
 wire \wb_uart_adr[27] ;
 wire \wb_uart_adr[28] ;
 wire \wb_uart_adr[29] ;
 wire \wb_uart_adr[2] ;
 wire \wb_uart_adr[30] ;
 wire \wb_uart_adr[31] ;
 wire \wb_uart_adr[3] ;
 wire \wb_uart_adr[4] ;
 wire \wb_uart_adr[5] ;
 wire \wb_uart_adr[6] ;
 wire \wb_uart_adr[7] ;
 wire \wb_uart_adr[8] ;
 wire \wb_uart_adr[9] ;
 wire wb_uart_clk;
 wire wb_uart_cyc;
 wire \wb_uart_dat_fromcpu[0] ;
 wire \wb_uart_dat_fromcpu[10] ;
 wire \wb_uart_dat_fromcpu[11] ;
 wire \wb_uart_dat_fromcpu[12] ;
 wire \wb_uart_dat_fromcpu[13] ;
 wire \wb_uart_dat_fromcpu[14] ;
 wire \wb_uart_dat_fromcpu[15] ;
 wire \wb_uart_dat_fromcpu[16] ;
 wire \wb_uart_dat_fromcpu[17] ;
 wire \wb_uart_dat_fromcpu[18] ;
 wire \wb_uart_dat_fromcpu[19] ;
 wire \wb_uart_dat_fromcpu[1] ;
 wire \wb_uart_dat_fromcpu[20] ;
 wire \wb_uart_dat_fromcpu[21] ;
 wire \wb_uart_dat_fromcpu[22] ;
 wire \wb_uart_dat_fromcpu[23] ;
 wire \wb_uart_dat_fromcpu[24] ;
 wire \wb_uart_dat_fromcpu[25] ;
 wire \wb_uart_dat_fromcpu[26] ;
 wire \wb_uart_dat_fromcpu[27] ;
 wire \wb_uart_dat_fromcpu[28] ;
 wire \wb_uart_dat_fromcpu[29] ;
 wire \wb_uart_dat_fromcpu[2] ;
 wire \wb_uart_dat_fromcpu[30] ;
 wire \wb_uart_dat_fromcpu[31] ;
 wire \wb_uart_dat_fromcpu[3] ;
 wire \wb_uart_dat_fromcpu[4] ;
 wire \wb_uart_dat_fromcpu[5] ;
 wire \wb_uart_dat_fromcpu[6] ;
 wire \wb_uart_dat_fromcpu[7] ;
 wire \wb_uart_dat_fromcpu[8] ;
 wire \wb_uart_dat_fromcpu[9] ;
 wire \wb_uart_dat_tocpu[0] ;
 wire \wb_uart_dat_tocpu[10] ;
 wire \wb_uart_dat_tocpu[11] ;
 wire \wb_uart_dat_tocpu[12] ;
 wire \wb_uart_dat_tocpu[13] ;
 wire \wb_uart_dat_tocpu[14] ;
 wire \wb_uart_dat_tocpu[15] ;
 wire \wb_uart_dat_tocpu[16] ;
 wire \wb_uart_dat_tocpu[17] ;
 wire \wb_uart_dat_tocpu[18] ;
 wire \wb_uart_dat_tocpu[19] ;
 wire \wb_uart_dat_tocpu[1] ;
 wire \wb_uart_dat_tocpu[20] ;
 wire \wb_uart_dat_tocpu[21] ;
 wire \wb_uart_dat_tocpu[22] ;
 wire \wb_uart_dat_tocpu[23] ;
 wire \wb_uart_dat_tocpu[24] ;
 wire \wb_uart_dat_tocpu[25] ;
 wire \wb_uart_dat_tocpu[26] ;
 wire \wb_uart_dat_tocpu[27] ;
 wire \wb_uart_dat_tocpu[28] ;
 wire \wb_uart_dat_tocpu[29] ;
 wire \wb_uart_dat_tocpu[2] ;
 wire \wb_uart_dat_tocpu[30] ;
 wire \wb_uart_dat_tocpu[31] ;
 wire \wb_uart_dat_tocpu[3] ;
 wire \wb_uart_dat_tocpu[4] ;
 wire \wb_uart_dat_tocpu[5] ;
 wire \wb_uart_dat_tocpu[6] ;
 wire \wb_uart_dat_tocpu[7] ;
 wire \wb_uart_dat_tocpu[8] ;
 wire \wb_uart_dat_tocpu[9] ;
 wire wb_uart_rst;
 wire \wb_uart_sel[0] ;
 wire \wb_uart_sel[1] ;
 wire \wb_uart_sel[2] ;
 wire \wb_uart_sel[3] ;
 wire wb_uart_stb;
 wire wb_uart_we;

 sky130_sram_2kbyte_1rw1r_32x512_8 dram_inst (.csb0(dram_csb0),
    .web0(dram_web0),
    .clk0(dram_clk0),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .addr0({\dram_addr0[8] ,
    \dram_addr0[7] ,
    \dram_addr0[6] ,
    \dram_addr0[5] ,
    \dram_addr0[4] ,
    \dram_addr0[3] ,
    \dram_addr0[2] ,
    \dram_addr0[1] ,
    \dram_addr0[0] }),
    .addr1({_NC1,
    _NC2,
    _NC3,
    _NC4,
    _NC5,
    _NC6,
    _NC7,
    _NC8,
    _NC9}),
    .din0({\dram_din0[31] ,
    \dram_din0[30] ,
    \dram_din0[29] ,
    \dram_din0[28] ,
    \dram_din0[27] ,
    \dram_din0[26] ,
    \dram_din0[25] ,
    \dram_din0[24] ,
    \dram_din0[23] ,
    \dram_din0[22] ,
    \dram_din0[21] ,
    \dram_din0[20] ,
    \dram_din0[19] ,
    \dram_din0[18] ,
    \dram_din0[17] ,
    \dram_din0[16] ,
    \dram_din0[15] ,
    \dram_din0[14] ,
    \dram_din0[13] ,
    \dram_din0[12] ,
    \dram_din0[11] ,
    \dram_din0[10] ,
    \dram_din0[9] ,
    \dram_din0[8] ,
    \dram_din0[7] ,
    \dram_din0[6] ,
    \dram_din0[5] ,
    \dram_din0[4] ,
    \dram_din0[3] ,
    \dram_din0[2] ,
    \dram_din0[1] ,
    \dram_din0[0] }),
    .dout0({\dram_dout0[31] ,
    \dram_dout0[30] ,
    \dram_dout0[29] ,
    \dram_dout0[28] ,
    \dram_dout0[27] ,
    \dram_dout0[26] ,
    \dram_dout0[25] ,
    \dram_dout0[24] ,
    \dram_dout0[23] ,
    \dram_dout0[22] ,
    \dram_dout0[21] ,
    \dram_dout0[20] ,
    \dram_dout0[19] ,
    \dram_dout0[18] ,
    \dram_dout0[17] ,
    \dram_dout0[16] ,
    \dram_dout0[15] ,
    \dram_dout0[14] ,
    \dram_dout0[13] ,
    \dram_dout0[12] ,
    \dram_dout0[11] ,
    \dram_dout0[10] ,
    \dram_dout0[9] ,
    \dram_dout0[8] ,
    \dram_dout0[7] ,
    \dram_dout0[6] ,
    \dram_dout0[5] ,
    \dram_dout0[4] ,
    \dram_dout0[3] ,
    \dram_dout0[2] ,
    \dram_dout0[1] ,
    \dram_dout0[0] }),
    .dout1({_NC10,
    _NC11,
    _NC12,
    _NC13,
    _NC14,
    _NC15,
    _NC16,
    _NC17,
    _NC18,
    _NC19,
    _NC20,
    _NC21,
    _NC22,
    _NC23,
    _NC24,
    _NC25,
    _NC26,
    _NC27,
    _NC28,
    _NC29,
    _NC30,
    _NC31,
    _NC32,
    _NC33,
    _NC34,
    _NC35,
    _NC36,
    _NC37,
    _NC38,
    _NC39,
    _NC40,
    _NC41}),
    .wmask0({\dram_wmask0[3] ,
    \dram_wmask0[2] ,
    \dram_wmask0[1] ,
    \dram_wmask0[0] }));
 sky130_sram_2kbyte_1rw1r_32x512_8 iram_inst (.csb0(iram_csb0),
    .web0(iram_web0),
    .clk0(iram_clk0),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .addr0({\iram_addr0[8] ,
    \iram_addr0[7] ,
    \iram_addr0[6] ,
    \iram_addr0[5] ,
    \iram_addr0[4] ,
    \iram_addr0[3] ,
    \iram_addr0[2] ,
    \iram_addr0[1] ,
    \iram_addr0[0] }),
    .addr1({_NC42,
    _NC43,
    _NC44,
    _NC45,
    _NC46,
    _NC47,
    _NC48,
    _NC49,
    _NC50}),
    .din0({\iram_din0[31] ,
    \iram_din0[30] ,
    \iram_din0[29] ,
    \iram_din0[28] ,
    \iram_din0[27] ,
    \iram_din0[26] ,
    \iram_din0[25] ,
    \iram_din0[24] ,
    \iram_din0[23] ,
    \iram_din0[22] ,
    \iram_din0[21] ,
    \iram_din0[20] ,
    \iram_din0[19] ,
    \iram_din0[18] ,
    \iram_din0[17] ,
    \iram_din0[16] ,
    \iram_din0[15] ,
    \iram_din0[14] ,
    \iram_din0[13] ,
    \iram_din0[12] ,
    \iram_din0[11] ,
    \iram_din0[10] ,
    \iram_din0[9] ,
    \iram_din0[8] ,
    \iram_din0[7] ,
    \iram_din0[6] ,
    \iram_din0[5] ,
    \iram_din0[4] ,
    \iram_din0[3] ,
    \iram_din0[2] ,
    \iram_din0[1] ,
    \iram_din0[0] }),
    .dout0({\iram_dout0[31] ,
    \iram_dout0[30] ,
    \iram_dout0[29] ,
    \iram_dout0[28] ,
    \iram_dout0[27] ,
    \iram_dout0[26] ,
    \iram_dout0[25] ,
    \iram_dout0[24] ,
    \iram_dout0[23] ,
    \iram_dout0[22] ,
    \iram_dout0[21] ,
    \iram_dout0[20] ,
    \iram_dout0[19] ,
    \iram_dout0[18] ,
    \iram_dout0[17] ,
    \iram_dout0[16] ,
    \iram_dout0[15] ,
    \iram_dout0[14] ,
    \iram_dout0[13] ,
    \iram_dout0[12] ,
    \iram_dout0[11] ,
    \iram_dout0[10] ,
    \iram_dout0[9] ,
    \iram_dout0[8] ,
    \iram_dout0[7] ,
    \iram_dout0[6] ,
    \iram_dout0[5] ,
    \iram_dout0[4] ,
    \iram_dout0[3] ,
    \iram_dout0[2] ,
    \iram_dout0[1] ,
    \iram_dout0[0] }),
    .dout1({_NC51,
    _NC52,
    _NC53,
    _NC54,
    _NC55,
    _NC56,
    _NC57,
    _NC58,
    _NC59,
    _NC60,
    _NC61,
    _NC62,
    _NC63,
    _NC64,
    _NC65,
    _NC66,
    _NC67,
    _NC68,
    _NC69,
    _NC70,
    _NC71,
    _NC72,
    _NC73,
    _NC74,
    _NC75,
    _NC76,
    _NC77,
    _NC78,
    _NC79,
    _NC80,
    _NC81,
    _NC82}),
    .wmask0({\iram_wmask0[3] ,
    \iram_wmask0[2] ,
    \iram_wmask0[1] ,
    \iram_wmask0[0] }));
 rvj1_caravel_soc rvj1_soc (.dram_clk0(dram_clk0),
    .dram_csb0(dram_csb0),
    .dram_web0(dram_web0),
    .iram_clk0(iram_clk0),
    .iram_csb0(iram_csb0),
    .iram_web0(iram_web0),
    .jedro_1_rstn(la_data_in[1]),
    .sel_wb(la_data_in[0]),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wb_uart_ack(wb_uart_ack),
    .wb_uart_clk(wb_uart_clk),
    .wb_uart_cyc(wb_uart_cyc),
    .wb_uart_rst(wb_uart_rst),
    .wb_uart_stb(wb_uart_stb),
    .wb_uart_we(wb_uart_we),
    .wbs_ack_o(wbs_ack_o),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .dram_addr0({_NC83,
    _NC84}),
    .dram_din0({\dram_din0[31] ,
    \dram_din0[30] ,
    \dram_din0[29] ,
    \dram_din0[28] ,
    \dram_din0[27] ,
    \dram_din0[26] ,
    \dram_din0[25] ,
    \dram_din0[24] ,
    \dram_din0[23] ,
    \dram_din0[22] ,
    \dram_din0[21] ,
    \dram_din0[20] ,
    \dram_din0[19] ,
    \dram_din0[18] ,
    \dram_din0[17] ,
    \dram_din0[16] ,
    \dram_din0[15] ,
    \dram_din0[14] ,
    \dram_din0[13] ,
    \dram_din0[12] ,
    \dram_din0[11] ,
    \dram_din0[10] ,
    \dram_din0[9] ,
    \dram_din0[8] ,
    \dram_din0[7] ,
    \dram_din0[6] ,
    \dram_din0[5] ,
    \dram_din0[4] ,
    \dram_din0[3] ,
    \dram_din0[2] ,
    \dram_din0[1] ,
    \dram_din0[0] }),
    .dram_dout0({\dram_dout0[31] ,
    \dram_dout0[30] ,
    \dram_dout0[29] ,
    \dram_dout0[28] ,
    \dram_dout0[27] ,
    \dram_dout0[26] ,
    \dram_dout0[25] ,
    \dram_dout0[24] ,
    \dram_dout0[23] ,
    \dram_dout0[22] ,
    \dram_dout0[21] ,
    \dram_dout0[20] ,
    \dram_dout0[19] ,
    \dram_dout0[18] ,
    \dram_dout0[17] ,
    \dram_dout0[16] ,
    \dram_dout0[15] ,
    \dram_dout0[14] ,
    \dram_dout0[13] ,
    \dram_dout0[12] ,
    \dram_dout0[11] ,
    \dram_dout0[10] ,
    \dram_dout0[9] ,
    \dram_dout0[8] ,
    \dram_dout0[7] ,
    \dram_dout0[6] ,
    \dram_dout0[5] ,
    \dram_dout0[4] ,
    \dram_dout0[3] ,
    \dram_dout0[2] ,
    \dram_dout0[1] ,
    \dram_dout0[0] }),
    .dram_wmask0({\dram_wmask0[3] ,
    \dram_wmask0[2] ,
    \dram_wmask0[1] ,
    \dram_wmask0[0] }),
    .iram_addr0({_NC85,
    _NC86}),
    .iram_din0({\iram_din0[31] ,
    \iram_din0[30] ,
    \iram_din0[29] ,
    \iram_din0[28] ,
    \iram_din0[27] ,
    \iram_din0[26] ,
    \iram_din0[25] ,
    \iram_din0[24] ,
    \iram_din0[23] ,
    \iram_din0[22] ,
    \iram_din0[21] ,
    \iram_din0[20] ,
    \iram_din0[19] ,
    \iram_din0[18] ,
    \iram_din0[17] ,
    \iram_din0[16] ,
    \iram_din0[15] ,
    \iram_din0[14] ,
    \iram_din0[13] ,
    \iram_din0[12] ,
    \iram_din0[11] ,
    \iram_din0[10] ,
    \iram_din0[9] ,
    \iram_din0[8] ,
    \iram_din0[7] ,
    \iram_din0[6] ,
    \iram_din0[5] ,
    \iram_din0[4] ,
    \iram_din0[3] ,
    \iram_din0[2] ,
    \iram_din0[1] ,
    \iram_din0[0] }),
    .iram_dout0({\iram_dout0[31] ,
    \iram_dout0[30] ,
    \iram_dout0[29] ,
    \iram_dout0[28] ,
    \iram_dout0[27] ,
    \iram_dout0[26] ,
    \iram_dout0[25] ,
    \iram_dout0[24] ,
    \iram_dout0[23] ,
    \iram_dout0[22] ,
    \iram_dout0[21] ,
    \iram_dout0[20] ,
    \iram_dout0[19] ,
    \iram_dout0[18] ,
    \iram_dout0[17] ,
    \iram_dout0[16] ,
    \iram_dout0[15] ,
    \iram_dout0[14] ,
    \iram_dout0[13] ,
    \iram_dout0[12] ,
    \iram_dout0[11] ,
    \iram_dout0[10] ,
    \iram_dout0[9] ,
    \iram_dout0[8] ,
    \iram_dout0[7] ,
    \iram_dout0[6] ,
    \iram_dout0[5] ,
    \iram_dout0[4] ,
    \iram_dout0[3] ,
    \iram_dout0[2] ,
    \iram_dout0[1] ,
    \iram_dout0[0] }),
    .iram_wmask0({\iram_wmask0[3] ,
    \iram_wmask0[2] ,
    \iram_wmask0[1] ,
    \iram_wmask0[0] }),
    .wb_uart_adr({\wb_uart_adr[31] ,
    \wb_uart_adr[30] ,
    \wb_uart_adr[29] ,
    \wb_uart_adr[28] ,
    \wb_uart_adr[27] ,
    \wb_uart_adr[26] ,
    \wb_uart_adr[25] ,
    \wb_uart_adr[24] ,
    \wb_uart_adr[23] ,
    \wb_uart_adr[22] ,
    \wb_uart_adr[21] ,
    \wb_uart_adr[20] ,
    \wb_uart_adr[19] ,
    \wb_uart_adr[18] ,
    \wb_uart_adr[17] ,
    \wb_uart_adr[16] ,
    \wb_uart_adr[15] ,
    \wb_uart_adr[14] ,
    \wb_uart_adr[13] ,
    \wb_uart_adr[12] ,
    \wb_uart_adr[11] ,
    \wb_uart_adr[10] ,
    \wb_uart_adr[9] ,
    \wb_uart_adr[8] ,
    \wb_uart_adr[7] ,
    \wb_uart_adr[6] ,
    \wb_uart_adr[5] ,
    \wb_uart_adr[4] ,
    \wb_uart_adr[3] ,
    \wb_uart_adr[2] ,
    \wb_uart_adr[1] ,
    \wb_uart_adr[0] }),
    .wb_uart_dat_fromcpu({\wb_uart_dat_fromcpu[31] ,
    \wb_uart_dat_fromcpu[30] ,
    \wb_uart_dat_fromcpu[29] ,
    \wb_uart_dat_fromcpu[28] ,
    \wb_uart_dat_fromcpu[27] ,
    \wb_uart_dat_fromcpu[26] ,
    \wb_uart_dat_fromcpu[25] ,
    \wb_uart_dat_fromcpu[24] ,
    \wb_uart_dat_fromcpu[23] ,
    \wb_uart_dat_fromcpu[22] ,
    \wb_uart_dat_fromcpu[21] ,
    \wb_uart_dat_fromcpu[20] ,
    \wb_uart_dat_fromcpu[19] ,
    \wb_uart_dat_fromcpu[18] ,
    \wb_uart_dat_fromcpu[17] ,
    \wb_uart_dat_fromcpu[16] ,
    \wb_uart_dat_fromcpu[15] ,
    \wb_uart_dat_fromcpu[14] ,
    \wb_uart_dat_fromcpu[13] ,
    \wb_uart_dat_fromcpu[12] ,
    \wb_uart_dat_fromcpu[11] ,
    \wb_uart_dat_fromcpu[10] ,
    \wb_uart_dat_fromcpu[9] ,
    \wb_uart_dat_fromcpu[8] ,
    \wb_uart_dat_fromcpu[7] ,
    \wb_uart_dat_fromcpu[6] ,
    \wb_uart_dat_fromcpu[5] ,
    \wb_uart_dat_fromcpu[4] ,
    \wb_uart_dat_fromcpu[3] ,
    \wb_uart_dat_fromcpu[2] ,
    \wb_uart_dat_fromcpu[1] ,
    \wb_uart_dat_fromcpu[0] }),
    .wb_uart_dat_tocpu({\wb_uart_dat_tocpu[31] ,
    \wb_uart_dat_tocpu[30] ,
    \wb_uart_dat_tocpu[29] ,
    \wb_uart_dat_tocpu[28] ,
    \wb_uart_dat_tocpu[27] ,
    \wb_uart_dat_tocpu[26] ,
    \wb_uart_dat_tocpu[25] ,
    \wb_uart_dat_tocpu[24] ,
    \wb_uart_dat_tocpu[23] ,
    \wb_uart_dat_tocpu[22] ,
    \wb_uart_dat_tocpu[21] ,
    \wb_uart_dat_tocpu[20] ,
    \wb_uart_dat_tocpu[19] ,
    \wb_uart_dat_tocpu[18] ,
    \wb_uart_dat_tocpu[17] ,
    \wb_uart_dat_tocpu[16] ,
    \wb_uart_dat_tocpu[15] ,
    \wb_uart_dat_tocpu[14] ,
    \wb_uart_dat_tocpu[13] ,
    \wb_uart_dat_tocpu[12] ,
    \wb_uart_dat_tocpu[11] ,
    \wb_uart_dat_tocpu[10] ,
    \wb_uart_dat_tocpu[9] ,
    \wb_uart_dat_tocpu[8] ,
    \wb_uart_dat_tocpu[7] ,
    \wb_uart_dat_tocpu[6] ,
    \wb_uart_dat_tocpu[5] ,
    \wb_uart_dat_tocpu[4] ,
    \wb_uart_dat_tocpu[3] ,
    \wb_uart_dat_tocpu[2] ,
    \wb_uart_dat_tocpu[1] ,
    \wb_uart_dat_tocpu[0] }),
    .wb_uart_sel({\wb_uart_sel[3] ,
    \wb_uart_sel[2] ,
    \wb_uart_sel[1] ,
    \wb_uart_sel[0] }),
    .wbs_adr_i({wbs_adr_i[31],
    wbs_adr_i[30],
    wbs_adr_i[29],
    wbs_adr_i[28],
    wbs_adr_i[27],
    wbs_adr_i[26],
    wbs_adr_i[25],
    wbs_adr_i[24],
    wbs_adr_i[23],
    wbs_adr_i[22],
    wbs_adr_i[21],
    wbs_adr_i[20],
    wbs_adr_i[19],
    wbs_adr_i[18],
    wbs_adr_i[17],
    wbs_adr_i[16],
    wbs_adr_i[15],
    wbs_adr_i[14],
    wbs_adr_i[13],
    wbs_adr_i[12],
    wbs_adr_i[11],
    wbs_adr_i[10],
    wbs_adr_i[9],
    wbs_adr_i[8],
    wbs_adr_i[7],
    wbs_adr_i[6],
    wbs_adr_i[5],
    wbs_adr_i[4],
    wbs_adr_i[3],
    wbs_adr_i[2],
    wbs_adr_i[1],
    wbs_adr_i[0]}),
    .wbs_dat_i({wbs_dat_i[31],
    wbs_dat_i[30],
    wbs_dat_i[29],
    wbs_dat_i[28],
    wbs_dat_i[27],
    wbs_dat_i[26],
    wbs_dat_i[25],
    wbs_dat_i[24],
    wbs_dat_i[23],
    wbs_dat_i[22],
    wbs_dat_i[21],
    wbs_dat_i[20],
    wbs_dat_i[19],
    wbs_dat_i[18],
    wbs_dat_i[17],
    wbs_dat_i[16],
    wbs_dat_i[15],
    wbs_dat_i[14],
    wbs_dat_i[13],
    wbs_dat_i[12],
    wbs_dat_i[11],
    wbs_dat_i[10],
    wbs_dat_i[9],
    wbs_dat_i[8],
    wbs_dat_i[7],
    wbs_dat_i[6],
    wbs_dat_i[5],
    wbs_dat_i[4],
    wbs_dat_i[3],
    wbs_dat_i[2],
    wbs_dat_i[1],
    wbs_dat_i[0]}),
    .wbs_dat_o({wbs_dat_o[31],
    wbs_dat_o[30],
    wbs_dat_o[29],
    wbs_dat_o[28],
    wbs_dat_o[27],
    wbs_dat_o[26],
    wbs_dat_o[25],
    wbs_dat_o[24],
    wbs_dat_o[23],
    wbs_dat_o[22],
    wbs_dat_o[21],
    wbs_dat_o[20],
    wbs_dat_o[19],
    wbs_dat_o[18],
    wbs_dat_o[17],
    wbs_dat_o[16],
    wbs_dat_o[15],
    wbs_dat_o[14],
    wbs_dat_o[13],
    wbs_dat_o[12],
    wbs_dat_o[11],
    wbs_dat_o[10],
    wbs_dat_o[9],
    wbs_dat_o[8],
    wbs_dat_o[7],
    wbs_dat_o[6],
    wbs_dat_o[5],
    wbs_dat_o[4],
    wbs_dat_o[3],
    wbs_dat_o[2],
    wbs_dat_o[1],
    wbs_dat_o[0]}),
    .wbs_sel_i({wbs_sel_i[3],
    wbs_sel_i[2],
    wbs_sel_i[1],
    wbs_sel_i[0]}));
 wbuart_wrap uart_inst (.clk_i(wb_clk_i),
    .rst_i(wb_rst_i),
    .uart_rx_i(io_in[9]),
    .uart_tx_o(io_out[10]),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wbs_ack_o(wb_uart_ack),
    .wbs_cyc_i(wb_uart_cyc),
    .wbs_stb_i(wb_uart_stb),
    .wbs_we_i(wb_uart_we),
    .wbs_adr_i({\wb_uart_adr[31] ,
    \wb_uart_adr[30] ,
    \wb_uart_adr[29] ,
    \wb_uart_adr[28] ,
    \wb_uart_adr[27] ,
    \wb_uart_adr[26] ,
    \wb_uart_adr[25] ,
    \wb_uart_adr[24] ,
    \wb_uart_adr[23] ,
    \wb_uart_adr[22] ,
    \wb_uart_adr[21] ,
    \wb_uart_adr[20] ,
    \wb_uart_adr[19] ,
    \wb_uart_adr[18] ,
    \wb_uart_adr[17] ,
    \wb_uart_adr[16] ,
    \wb_uart_adr[15] ,
    \wb_uart_adr[14] ,
    \wb_uart_adr[13] ,
    \wb_uart_adr[12] ,
    \wb_uart_adr[11] ,
    \wb_uart_adr[10] ,
    \wb_uart_adr[9] ,
    \wb_uart_adr[8] ,
    \wb_uart_adr[7] ,
    \wb_uart_adr[6] ,
    \wb_uart_adr[5] ,
    \wb_uart_adr[4] ,
    \wb_uart_adr[3] ,
    \wb_uart_adr[2] ,
    \wb_uart_adr[1] ,
    \wb_uart_adr[0] }),
    .wbs_dat_i({\wb_uart_dat_fromcpu[31] ,
    \wb_uart_dat_fromcpu[30] ,
    \wb_uart_dat_fromcpu[29] ,
    \wb_uart_dat_fromcpu[28] ,
    \wb_uart_dat_fromcpu[27] ,
    \wb_uart_dat_fromcpu[26] ,
    \wb_uart_dat_fromcpu[25] ,
    \wb_uart_dat_fromcpu[24] ,
    \wb_uart_dat_fromcpu[23] ,
    \wb_uart_dat_fromcpu[22] ,
    \wb_uart_dat_fromcpu[21] ,
    \wb_uart_dat_fromcpu[20] ,
    \wb_uart_dat_fromcpu[19] ,
    \wb_uart_dat_fromcpu[18] ,
    \wb_uart_dat_fromcpu[17] ,
    \wb_uart_dat_fromcpu[16] ,
    \wb_uart_dat_fromcpu[15] ,
    \wb_uart_dat_fromcpu[14] ,
    \wb_uart_dat_fromcpu[13] ,
    \wb_uart_dat_fromcpu[12] ,
    \wb_uart_dat_fromcpu[11] ,
    \wb_uart_dat_fromcpu[10] ,
    \wb_uart_dat_fromcpu[9] ,
    \wb_uart_dat_fromcpu[8] ,
    \wb_uart_dat_fromcpu[7] ,
    \wb_uart_dat_fromcpu[6] ,
    \wb_uart_dat_fromcpu[5] ,
    \wb_uart_dat_fromcpu[4] ,
    \wb_uart_dat_fromcpu[3] ,
    \wb_uart_dat_fromcpu[2] ,
    \wb_uart_dat_fromcpu[1] ,
    \wb_uart_dat_fromcpu[0] }),
    .wbs_dat_o({\wb_uart_dat_tocpu[31] ,
    \wb_uart_dat_tocpu[30] ,
    \wb_uart_dat_tocpu[29] ,
    \wb_uart_dat_tocpu[28] ,
    \wb_uart_dat_tocpu[27] ,
    \wb_uart_dat_tocpu[26] ,
    \wb_uart_dat_tocpu[25] ,
    \wb_uart_dat_tocpu[24] ,
    \wb_uart_dat_tocpu[23] ,
    \wb_uart_dat_tocpu[22] ,
    \wb_uart_dat_tocpu[21] ,
    \wb_uart_dat_tocpu[20] ,
    \wb_uart_dat_tocpu[19] ,
    \wb_uart_dat_tocpu[18] ,
    \wb_uart_dat_tocpu[17] ,
    \wb_uart_dat_tocpu[16] ,
    \wb_uart_dat_tocpu[15] ,
    \wb_uart_dat_tocpu[14] ,
    \wb_uart_dat_tocpu[13] ,
    \wb_uart_dat_tocpu[12] ,
    \wb_uart_dat_tocpu[11] ,
    \wb_uart_dat_tocpu[10] ,
    \wb_uart_dat_tocpu[9] ,
    \wb_uart_dat_tocpu[8] ,
    \wb_uart_dat_tocpu[7] ,
    \wb_uart_dat_tocpu[6] ,
    \wb_uart_dat_tocpu[5] ,
    \wb_uart_dat_tocpu[4] ,
    \wb_uart_dat_tocpu[3] ,
    \wb_uart_dat_tocpu[2] ,
    \wb_uart_dat_tocpu[1] ,
    \wb_uart_dat_tocpu[0] }),
    .wbs_sel_i({\wb_uart_sel[3] ,
    \wb_uart_sel[2] ,
    \wb_uart_sel[1] ,
    \wb_uart_sel[0] }));
endmodule
