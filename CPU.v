module CPU(clock,reset,r0,r1,r2,r3,r4,r5,r6,r7);

input clock, reset;

output [15:0] r0,r1,r2,r3,r4,r5,r6,r7;

wire [31:0] IR;
wire [4:0] SA, SB, DA; 
wire W, EN_B, B_sel, EN_ALU, EN_Addr, C0, OUT_EN, WR_EN, PCSel, EN_PC,IL, FlagSet;
wire [63:0] K;
wire [4:0] FS;
wire [2:0] PS;
wire ENADDRESS_PC;
wire [31:0]PCAddressWire;
wire [31:0]PCInputWire;
wire [63:0] data;
wire[3:0] FlagReg; //Flag Register. Output from our datapath. Needed for branch conditions
wire fake_reset;
//---------------------------------------------------------

//Instatiations of our datapath and control unit
datapath1 DATAPATH(SA, SB, DA, W, clock, reset, EN_B, B_sel, EN_ALU, EN_Addr, ENADDRESS_PC, WR_EN, OUT_EN, K, FS, C0, PS,PCSel,
		EN_PC,IL,FlagSet,FlagReg,IR,r0,r1,r2,r3,r4,r5,r6,r7);

ControlUnit CONTROL(clock,FlagReg,IR, SA,SB,DA,W,fake_reset,EN_B,B_sel,EN_ALU,EN_Addr,ENADDRESS_PC,WR_EN,
OUT_EN,K,FS,C0,PS,PCSel,EN_PC,IL,FlagSet);		/*,r0, r1, r2, r3, r4, r5, r6, r7);*/


	
endmodule