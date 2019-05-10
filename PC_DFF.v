module PC_DFF (Q, D, clk, rst);
	output reg [31:0] Q;
	input [31:0] D;
	input clk, rst;
	
	parameter PC_RESET_VALUE = 32'h80000000;
	
	always @ (posedge clk or posedge rst) begin
		if(rst)
			Q <= PC_RESET_VALUE;
		else
			Q <= D;
	end
endmodule
