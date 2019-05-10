module ProgramCounter(PC, in, PS, clock, reset);
	input [31:0]in;
	input [2:0]PS; // Program counter function Select bits
	// PS
	// 00 - PC <= PC
	// 01 - PC <= PC+4
	// 10 - PC <= in
	// 11 - PC <= PC+4+in*4
	input clock, reset;
	output[31:0]PC; //I this this needs to be 32 bits
	wire [31:0]PC4;
	
	wire [31:0] PC_in; // input to program counter / output from mux
	wire [31:0] AdderOut; // output of offeset adder
	wire load_PC;
	assign load_PC = 1'b1;
	assign PC4 = PC + 4; // +4 adder
	assign AdderOut = PC4 + {in[31:0], 2'b00};
	Mux4to1Nbit PC_Mux (PC_in, PS, PC, PC4, in, AdderOut);
	defparam PC_Mux.N = 32;
	RegisterNbit PC_Reg (PC, PC_in, load_PC, reset, clock);
	defparam PC_Reg.N = 32;
endmodule