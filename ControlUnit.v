module ControlUnit(clock,FlagReg,IR, SA,SB,DA,W,reset,EN_B,B_sel,EN_ALU,EN_Addr,ENADDRESS_PC,WR_EN,
OUT_EN,K,FS,C0,PS,PCSEL,EN_PC,IL,FlagSet/*,r0, r1, r2, r3, r4, r5, r6, r7*/);

//SA, SB, DA, W, clock, reset, EN_B, B_sel, EN_ALU, EN_Addr, ENADDRESS_PC, WR_EN, OUT_EN, K, FS, C0, PS,PCSel,

//CZNB

input [3:0] FlagReg;
input [31:0]IR;
reg [101:0]ControlWord; //I don't think this has to be an output, but I'm also not sure.
input clock;
assign ControlWord_VIZ = ControlWord;

//assign TestBenchInstructionReg = IR;
//output reg [63:0] r0, r1, r2, r3, r4, r5, r6, r7;
output reg [4:0] SA, SB, DA; 
output reg W, EN_B, B_sel, EN_ALU, EN_Addr, C0, OUT_EN, WR_EN, PCSEL, EN_PC,IL,FlagSet,reset;
output reg [63:0] K;
output reg[4:0] FS;
output reg [2:0] PS;
output reg ENADDRESS_PC;

wire[1:0] nextState,SNS;


always @(posedge clock) begin

//#10
case(SNS)
//IF
2'b00: ControlWord = 102'b010000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000010010;



2'b01:	case(IR[26]) //This seperates branch statements from basic boring logic statements.
					
				1'b0: case (IR[25:23]) 
					
					3'b000 :  case( {IR[31],IR[22]} ) //DFORMAT
					//104
						/*SturB */	2'b00 : ControlWord = {2'b0,IR[9:5], 96'b00000000001011010100000000000000000000000000000000000000000000000000000000011111111000000000000};
						/*LDURB*/	2'b01 : ControlWord = {2'b0,IR[9:5], 5'b00000 , IR[4:0], 85'b1000000110000000000000000000000000000000000000000000000000000000011111111000000000000};
						/*STUR*/		2'b10 : ControlWord = {2'b0,IR[9:5], 68'b00000000000011010100000000000000000000000000000000000000000000000000000,IR[20:7],	12'b010000000000};
						/*LDUR*/		2'b11 : ControlWord = {2'b0,5'b00000, 5'b00000, IR[4:0], 72'b1000000010000000000000000000000000000000000000000000000000000,IR[20:7],	12'b000000000000};
								endcase
								
					3'b001 : ControlWord = 102'b00000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000;
						
						
					3'b010 :  case( {IR[30],IR[29]} )  //IFORM
						/*ADDI*/		2'b00 : ControlWord = {2'b0,IR[9:5], 5'b00000,	IR[4:0], 61'b1001100000000000000000000000000000000000000000000000000000000,IR[21:10],	12'b010000001000};
						/*ADDIS*/	2'b01 : ControlWord = {2'b0,IR[9:5],5'b00000,IR[4:0],61'b1001100000000000000000000000000000000000000000000000000000000,IR[21:10],12'b010000001001};
						/*SUBI*/		2'b10 : ControlWord = {2'b0,IR[9:5],	5'b00000,	IR[4:0], 61'b1001100000000000000000000000000000000000000000000000000000000,IR[21:10],	12'b010011001000};
						/*SUBIS*/	2'b11 : ControlWord = {2'b0,IR[9:5], 5'b00000,	IR[4:0],	61'b1000100000000000000000000000000000000000000000000000000000000,IR[21:10],	12'b010011000001};
								endcase
						
					
					3'b100 : case(IR[28])    //LOGICAL IMMEDIATE   
					
						1'b1 : case({IR[30],IR[29]})//Check if bit seven is 1 or 0
						
							/*ANDI*/	 2'b00 :	ControlWord = {2'b0,IR[9:5],5'b00000,	IR[4:0],59'b10011000000000000000000000000000000000000000000000000000000,IR[20:9],12'b000000000000};
							/*ORRI*/	 2'b01 : ControlWord = {2'b0,IR[9:5],5'b00000,IR[4:0],59'b10011000000000000000000000000000000000000000000000000000000,IR[20:9],12'b001000000000};
							/*EORI*/	 2'b10 : ControlWord = {2'b0,IR[9:5],5'b00000,IR[4:0],59'b10011000000000000000000000000000000000000000000000000000000,IR[20:9],12'b011000000000};
							/*ANDIS*/ 2'b11 : ControlWord = {2'b0,IR[9:5],5'b00000,IR[4:0],59'b10011000000000000000000000000000000000000000000000000000000,IR[20:9],12'b000000000001};
							endcase
						1'b0 : case({IR[30],IR[29]})
							/*AND*/	 2'b00 :	ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000000000000000};
							/*ORR*/	 2'b01 : ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000001000000000};
							/*EOR*/	 2'b10 : ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000011000000000};
							/*ANDS*/  2'b11 : ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000000000000001};
							
								endcase
								
						endcase
					
					3'b101: case(IR[27]) //MOVEZ/MOVEK
							/*MoveZ*/ 1'b0: ControlWord = {102'bz};//FINISH THIS PLS
							/*MoveK*/ 1'b1: ControlWord = {2'b10,IR[4:0],5'b00000,IR[4:0],9'b000010000,48'b1, 16'bz,12'b000000000000};
							endcase
					
					
					3'b110:  case({IR[30:29],IR[22:21]}) //Arthithmatic/Shift | The second part differentiates between Shift and Logic
							/*ADD*/ 4'b0000 : ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000010000000100};
							/*ADDS*/4'b0100 : ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000010000000101};
							/*SUB*/ 4'b1000 : ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000010011000000};	
							/*SUBS*/4'b1100 : ControlWord = {2'b0,IR[9:5],IR[20:16],IR[4:0],85'b1000100000000000000000000000000000000000000000000000000000000000000000000010011000000};
							/*LSR*/ 4'b1010 : ControlWord = {2'b0,IR[9:5], 5'b00000,IR[4:0],67'b1001100000000000000000000000000000000000000000000000000000000000000,IR[15:10],12'b101000000000};
							/*LSL*/ 4'b1010 : ControlWord = {2'b0,IR[9:5],5'b00000,IR[4:0],67'b1001100000000000000000000000000000000000000000000000000000000000000,IR[15:10],12'b100000000000};
								endcase
					
					endcase
						
				1'b1 : case(IR[31:29])
				/*B*/			3'b000 : ControlWord = {2'b0,62'b00000000000000000000000000000000000000000000000000000000000000,IR[25:0],12'b000000101000};
				/*BCOND*/	3'b010 : //I'm using an IF statement. If you're reading this, I'm sorry.e  //V, C, N, Z
								case(IR[4:0])
				
						/*EQ*/5'b00000 :	if (FlagReg[0] == 1'b1) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end 
						/*NE*/5'b00001 :	if (FlagReg[0] == 1'b0) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*HS*/5'b00010 :	if (FlagReg[2] == 1'b1) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*LO*/5'b00011 :	if(FlagReg[2] == 1'b0) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*MI*/5'b00100 :	if(FlagReg[1] == 1'b1) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*PL*/5'b00101 :	if(FlagReg[1] == 1'b0) begin
												ControlWord = {2'b0,62'b00000000000000000000000000000000000000000000000000000000000000,IR[25:0],12'b000000101000};
												end
						/*VS*/5'b00110 : 	if(FlagReg[3] == 1'b1) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*VC*/5'b00111 :	if(FlagReg[3] == 1'b0) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*HI*/5'b01000 :	if(FlagReg[2] == 1'b1 & FlagReg[0] == 1'b0) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*LS*/5'b01001 :	if(FlagReg[2] == 1'b0 | FlagReg[0] == 1'b1) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*GE*/5'b01010 :	if (~(FlagReg[1]^FlagReg[3])) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*LT*/5'b01011	:	if(FlagReg[1]^FlagReg[3]) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*GT*/5'b01100	:	if( FlagReg[0] & (~(FlagReg[1]^FlagReg[3] )) ) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
						/*LE*/5'b01101	:	if( FlagReg[0] | (FlagReg[1]^FlagReg[3]) ) begin
													ControlWord = {2'b0,IR[4:0],64'b0000000000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b000000101000};
												end
											
								endcase
								/*AL*/
								
								/*NV*/
								
				/*BL*/		3'b100 : ControlWord = {2'b0,IR[4:0],94'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000};
				/*CBZ/CBNC*/3'b101 : case(IR[24])//this is going to be the CBZ/CBNZ)
				
								/*CBZ*/	1'b0 : if (FlagReg[0] == 1) begin
														ControlWord = {2'b0,IR[4:0],64'b1111100000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b010001101001};
													end else if(FlagReg[0] == 0) begin
									/*IF 0, IF*/	ControlWord = 102'b0010001000000000000000000000000000000000000000000000000000000000000000000000000000100100000;
													end
								/*CZNB*/	1'b1 : if(FlagReg[0] == 1) begin
									/*IF1, IF*/		ControlWord = {2'b0,IR[4:0],64'b1111100000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b010001101001};
													end else if (FlagReg[1] == 0) begin
														ControlWord = {2'b0,IR[4:0],64'b1111100000000000000000000000000000000000000000000000000000000000,IR[23:5],12'b010001101001};
													end
											endcase
											
				/*BR*/		//3'b110 : 
			
				
				endcase
				
				endcase
	
	
2'b10: ControlWord = {2'b00,IR[4:0],5'b00000,IR[4:0],9'b000100000,48'bz,IR[20:4],12'b001000000000};
default : ControlWord = 102'b010000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000010010;
endcase
			SA <= ControlWord[99:95];
			SB <= ControlWord[94:90];
			DA <= ControlWord[89:85];
			W <= ControlWord[84];
			reset <= ControlWord[83];
			EN_B <= ControlWord[82];
			B_sel <= ControlWord[81];
			EN_ALU <= ControlWord[80];
			EN_Addr <= ControlWord[79]; 
			ENADDRESS_PC <= ControlWord[78];
			WR_EN <= ControlWord[77];
			OUT_EN <= ControlWord[76];
			K <= ControlWord[75:12];
			FS <= ControlWord[11:7];
			C0 <= ControlWord[6];
			PS <= ControlWord[5:4];
			PCSEL <= ControlWord[3];
			EN_PC <= ControlWord[2];
			IL <= ControlWord[1];
			FlagSet <= ControlWord[0];
			
end
		
			
		






assign nextState = ControlWord[101:100];

StateReg twelveAMregister (SNS, nextState , 1'b1 , reset,clock); 
//Q, D, L, R, clock


endmodule
