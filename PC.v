module PC (clk, rst, in, out, PS);
	parameter ROM_BASE = 32'h00060000;
	input [31:0] in;
	input [1:0] PS;
	input clk, rst;
	output [31:0] out;
	
	parameter cons = 32'h00000004;
	wire[31:0] mux1, mux2, addo, mux3;
	
	assign mux1 = PS[1]?{in[29:0], 2'b00}:cons;
	assign mux2 = PS[1]?in:out;
	assign addo = mux1 + out;
	assign mux3 = PS[0]?addo:mux2;
	
	PC_DFF dff_inst (out, mux3, clk, rst);
	defparam dff_inst.PC_RESET_VALUE = ROM_BASE;
	
endmodule
