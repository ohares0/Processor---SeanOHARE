
/*
	Grant,Niko,Sean
	------------------
	Notes: Make sure to change the size of the RAM accordingly, not worried about rn, just trying to hook everything
				together3
				
			Assistance required with the datainput of the RAM file!
			
	-------------------
	
	
*/
module Datapath(clock, SA, SB, DA, /*D,*/ reset, W, EN_B, K, F, FS, C_in, B_SEL, EN_ALU, /*EN_Addr, Data,*/ r0, r1, r2, r3, r4, r5, r6, r7);


//----REG INPUT/OUTPUT----------
input [4:0]SA,SB; 	//Select what address to push to either A/B Bus
//input [63:0] D; 	//Data input for registers // THIS WIL BE A WIRE
input [4:0] DA;		//Select address for data to be written
input reset,clock;	//reset and the clock input for the reg file

output [16:0]r0,r1,r2,r3,r4,r5,r6,r7; //outdoots

//----ALU INPUT/OUTPUT-----------
							//[63:0] A,B ; // Wires, Wires, WIRES!
input [4:0] FS;
input C_in;

output[63:0]F; 		//I think that K is the ALU output?


//----RAM INPUT/OUTPUT------------
input W;					//Write enable for the register file							//Not beep boop boop beep. 
//input Data;					//Use as much whitespace as you need there buddy. We don't punch holes in cards so memory is free!

							
//---DID SOMEONE SAY TRI - TRI - TRI STATE BUFFER?--
input EN_ALU; 			//ALU ENABLER 
input EN_B;				//THE SOMETHING ENABLER | NOTE: 			*******FIND OUT WHAT THIS IS!*******
//input EN_Addr;
//---MUX MUX---
input B_SEL;

//---Program Counter---
//This will also require a mux but that's future Grant's problem 
output[63:0]K;

//----------------------------------------------------------------------------




//----Wires---
wire [63:0] A, B, D;
wire [4:0] FS, DA ;
wire [31:0] EN_Addr,	Address; //Wire from the En_Addr Tri-state buffer to the RAM
//inout Data, D;


//----Object instantiation!------

RegisterFile32x64 yeOldeRegFile(A, B, SA, SB, D, DA, W, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7); //Instantiate the RegisterFile

ALU_LEGv8 yeOldeAlu(A, B, FS, C_in, F, status); //Instantiate the ALU 

//ram(clock, Address, data,W,oe); //Instantiate ye ol' RAM
												//									***NOTE: ADD CHIP SELECT/OUTPUT ENABLE?

tri_buf aluTriBuf(F,D,EN_ALU); 	//This is the ALU enable. If on it feeds back to the data input of the Reg file
tri_buf regTriBuf(B, D ,EN_B); 	//B enable. Buffer from B bus to the REG

//tri_buf(F, Address, EN_Addr); // This is the buffer for the RAM. 






endmodule






