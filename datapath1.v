module datapath1(SA, SB, DA, W, clock, reset, EN_B, B_sel, EN_ALU, EN_Addr, ENADDRESS_PC, WR_EN, OUT_EN, K, FS, C0, PS,PCSel,
		EN_PC,IL,FlagSet,FlagReg,IR,r0,r1,r2,r3,r4,r5,r6,r7);

	 
// Inputs
output [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
input [4:0] SA, SB, DA; 
input W, EN_B, B_sel, EN_ALU, EN_Addr, C0, clock, reset, OUT_EN, WR_EN, PCSel, EN_PC,IL, FlagSet;
input [63:0] K;
input [4:0] FS;
input [2:0] PS;
input ENADDRESS_PC;
wire [63:0] F;
output[31:0]IR;
wire [63:0] A, B, B_signal, D;
wire [3:0]status;
wire [31:0]Address;
wire [31:0]PCAddressWire;
wire [31:0]PCInputWire;
wire[63:0] data;
output wire[3:0] FlagReg;

RegisterFile32x64 regfile(A, B, SA, SB, data, DA, W, reset, clock, r0,r1,r2,r3,r4,r5,r6,r7);

assign B_signal = B_sel ? K : B;

assign D = EN_B ? B : 64'bz; //Enable B Tri-state


ALU_LEGv8 alu(A, B_signal, FS, C0, F, status); //ALU Instantiation


assign data = EN_ALU ? F : 64'bz; //Enable ALU tri state buffer

 
assign Address = EN_Addr ? F[31:0] : 64'bz; //Enable Ram Address Tri buffer

wire cs_ram, cs_rom, cs_per;

wire [31:0] rom_data;

Address_detect ram_detect(Address,cs_ram);
defparam ram_detect.base = 32'h00010000;
defparam ram_detect.mask = 32'hFFFFF800;

Address_detect rom_detect (Address,cs_rom);
defparam rom_detect.base = 32'h00060000;
defparam rom_detect.mask = 32'hFFFFFC00;

assign data = (cs_rom & OUT_EN) ? {32'b0, rom_data} : 64'bz;

ram yeOldeRam( clock, Address[10:3], data, cs_ram , WR_EN , OUT_EN );

rom_case rom(rom_data,Address[7:0]);

//This garbage past here will be the instatiation for the Program Counter

assign Address = ENADDRESS_PC ? PCAddressWire : 32'bz; //This is the ENADDRESS_PC Tri-state Buffer

//PC, in, PS, clock, reset

PC counterProgram (clock,reset, PCInputWire , PCAddressWire , PS[1:0]);
//PCSel will be used for the mux

assign PCInputWire = PCSel ? K[31:0] : A[31:0];

assign data = EN_PC ? PCAddressWire : 64'bz; //This is the EN_PC Tri-state buffer guy :)

InstructionRegister InstructionReg(IR,data[31:0],IL,reset,clock);

SetFlagReg Flags(FlagReg,status,FlagSet,reset,clock);



endmodule

module Address_detect(address,out);
	input [31:0] address;
	output out;
	
	parameter base = 32'h00000000;
	parameter mask = 32'hFFFFFFFF;
	
	assign out = ((address & mask) == base);
	
endmodule 