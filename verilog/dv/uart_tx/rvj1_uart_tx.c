// Basic test of uart
#include "defs.h"

#define UART_BASE_ADDR (0x30010000)
#define UART_SETUP_REG_ADDR   (UART_BASE_ADDR + 0)
#define UART_FIFO_REG_ADDR    (UART_BASE_ADDR + 4)
#define UART_RX_DATA_REG_ADDR (UART_BASE_ADDR + 8)
#define UART_TX_DATA_REG_ADDR (UART_BASE_ADDR + 12)

#define uart_setup_reg   (*((volatile uint32_t*)UART_SETUP_REG_ADDR))
#define uart_fifo_reg    (*((volatile uint32_t*)UART_FIFO_REG_ADDR))
#define uart_rx_data_reg (*((volatile uint32_t*)UART_RX_DATA_REG_ADDR))
#define uart_tx_data_reg (*((volatile uint32_t*)UART_TX_DATA_REG_ADDR))

#define UART_INIT 0x40000019


void main()
{
	uart_setup_reg = (uint32_t)UART_INIT;
	while(uart_setup_reg != UART_INIT);

	uart_tx_data_reg = (uint32_t)(104);
	while(1);
}
