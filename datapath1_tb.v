module datapath1_tb();
/*
reg [4:0]SA; // Select A - A Address
reg [4:0]SB; // Select B - B Address
reg [4:0]DA; // Data destination address
reg W; // write enable
//reg [3:0] status;
reg reset; // positive logic asynchronous reset
reg [4:0]FS;
reg C0;
reg [63:0]K;
reg EN_B;
reg EN_ALU;
reg B_sel;
reg WR_EN;
reg [2:0]PS;
reg PCSel;
reg EN_PC;
reg ENADDRESS_PC;

wire [63:0]F;
wire [63:0]data;
//reg mem_read;
//reg EN_PC;
//reg [63:0] A,B;

wire [3:0]status;
*/
//New Stuff, Importing for the RAM woo!//
reg clock;
reg OUT_EN;
reg EN_ADDR;
reg [31:0]IR;
reg [3:0]FlagReg;

datapath1 dut(IL,FlagReg, r0, r1, r2, r3, r4, r5, r6, r7);

initial begin
//--------------Initial Values----------------

//--------------------------------

end



always
#5 clock <= ~clock;

endmodule
