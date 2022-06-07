`default_nettype none

`timescale 1 ns / 1 ps

module timer_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	wire [7:0] mprj_io_0;
	wire [24-1:0] timer_bits;

	pullup(mprj_io[3]);                                                                                                 
    assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.
	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	initial begin
		$dumpfile("timer.vcd");
		$dumpvars(0, timer_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (160) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test timer basic WB Port (GL) FAILED!!!!!!!!!!!!!!!!!!!!!!!!!");
		`else
			$display ("Monitor: Timeout, Test in timer basic WB Port (RTL) FAILED!!!!!!!!!!!!!!!!!!!!!");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	initial begin
		$display("Monitor: GPIo basic WB Started");
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h0);
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h15);
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h0);
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h15);
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h0);
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h15);
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h0);
		wait(uut.mprj.rvj1_soc.timer_inst.time_ff == 32'h15);
		repeat (400) @(posedge clock);
		`ifdef GL
	    	$display("Monitor: timer basic WB (GL) PASSED------------------------------");
		`else
		    $display("Monitor: timer basic WB (RTL) PASSED-----------------------------");
		`endif
	    $finish;
	end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#100000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3 = power1;
	wire VDD1V8 = power2;
	wire USER_VDD3V3 = power3;
	wire USER_VDD1V8 = power4;
	wire VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("timer.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
