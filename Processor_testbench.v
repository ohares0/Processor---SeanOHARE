module Processor_testbench();
	reg clk,rst;
	wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7;
	
	CPU dut(clk,rst,r0,r1,r2,r3,r4,r5,r6,r7);
	
	initial begin 
		clk <=1'b1;
		rst <=1'b1;
		#5 rst <= 1'b0;
		
		#10000 $stop;
	end
	
	always begin
		#5 clk <= ~clk;

	end
	
endmodule
