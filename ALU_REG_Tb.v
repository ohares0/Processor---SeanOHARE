module ALU_REG_Tb ();
reg [4:0] AA, BA, DA, FS;
reg RST, WR, EN_B, EN_ALU, CLK, Cin, B_sel;
reg [63:0] K;
//reg [3:0] status;
wire [3:0] status;
reg [63:0] A, B; 
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;

Datapath dut (CLK, AA, BA, DA, RST, WR, EN_B, K, FS, Cin, B_sel, EN_ALU, status, F, 
r0, r1, r2, r3, r4, r5, r6, r7);


//module Datapath(clock, SA, SB, DA, /*D,*/ reset, W, EN_B, K, F, FS, C_in, B_SEL, EN_ALU, EN_Addr, Data, r0, r1, r2, r3, r4, r5, r6, r7);
 
initial begin 
WR <= 1'b1;
CLK <= 1'b1;
B_sel <= 1'b1;
RST <= 1'b0; //positive logic
AA <= 5'd31; //SA
BA <= 5'd5; //SB
DA <= 5'd4;
FS <= 5'b01000;
EN_ALU <= 1'b1;
Cin <= 1'b0;
EN_B <= 1'b0;
A <= 64'd0;
B <= 64'd0;

#10;
DA <= 5'd0;
#10;
K <= 64'd5;
#10;
DA <= 5'd1;
//#10;
//K <= 64'd12;
#10;
DA <= 5'd2;
//#10;
//K <= 64'd16;
#10;
DA <= 5'd3;
//#10;
//K <= 64'd7;
#10;
DA <= 5'd4;
//#10;
//K <= 64'd3;
#10;
DA <= 5'd5;
//#10;
//K <= 64'd9;
#10;
DA <= 5'd6;
//#10
//K <= 64'd13;
#10;
DA <= 5'd7;
#200 $stop;
end

always 
#5 CLK <= ~CLK;

endmodule 