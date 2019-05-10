module ControlUnit_tb();
//module CPU(r0,r1,r2,r3,r4,r5,r6,r7,IR);

reg [31:0]IR_SET; 
reg clock;
wire [4:0] SA_VIZ,SB_VIZ,DA_VIZ;
wire [15:0] r0,r1,r2,r3,r4,r5,r6,r7;
wire W_VIZ,EN_B_VIZ,B_sel_VIZ,EN_ALU_VIZ,EN_ADDR_VIZ,C0_VIZ,reset_VIZ,FlagSet_VIZ;
wire[63:0] K_VIZ;
wire[4:0] FS_VIZ;
wire[2:0] PS_VIZ;
wire ENADDRESS_PC_VIZ;
wire[3:0] FlagReg_VIZ;

wire[99:0]ControlWord_VIZ;

CPU dut(r0,r1,r2,r3,r4,r5,r6,r7,IR_SET, SA_VIZ,SB_VIZ,DA_VIZ,
W_VIZ, EN_B_VIZ, B_sel_VIZ, EN_ALU_VIZ, 
EN_ADDR_VIZ, K_VIZ, FS_VIZ, PS_VIZ, ENADDRESS_PC_VIZ, FlagReg_VIZ,C0_VIZ,ControlWord_VIZ,reset_VIZ,FlagSet_VIZ,clock);

initial begin
//--------------Initial Values----------------
clock <= 1'b1;
IR_SET <= 32'b00000000100000000000000000000000;
#100
//IR_SET <= 32'b10101011000000100000000000100001;

IR_SET <= 32'b10101011000000100000000000000001;

//IR_SET <= 32'b10110001001111111111110000100001; //ADD 12'b1+X1 -> X3; | Next, we'll add all ones to register three so that we overflow.

//IR_SET <= 32'b10010001000000000010000001000010;


//IR_SET <= 32'b10001011000000010000000001010000; //ADD

 
//--------------------------------

end



always
#5 clock <= ~clock; //TICK TOCK HERES THE CLOCK

endmodule
