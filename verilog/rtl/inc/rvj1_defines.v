`define JEDRO_1_BOOT_ADDR 	  (32'h3000_0000)

`define IRAM_BASE_ADDR        (32'h3000_0000)
`define IRAM_ADDR_WIDTH_BYTES ($clog2(2048))
`define IRAM_ADDR_WIDTH_WORDS (`IRAM_ADDR_WIDTH_BYTES - 2)

`define DRAM_BASE_ADDR        (32'h3000_4000)
`define DRAM_ADDR_WIDTH_BYTES ($clog2(2048))
`define DRAM_ADDR_WIDTH_WORDS (`DRAM_ADDR_WIDTH_BYTES - 2)