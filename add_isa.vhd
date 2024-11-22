library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity add_isa is
	port( clock, reset : in std_logic;
	current_pc, result : out std_logic_vector(3 downto 0));
end add_isa;

architecture behaviour of add_isa is
	constant initial_pc : std_logic_vector(3 downto 0) := (others => '0');
	signal update_pc, read_port1, read_port2, write_port, write_portMux, w_value, pc_new_jump, src1, branch_update, pc_new, src2, memOut, muxALU, writeDatas, sum, rout, mout,mout2, regWriteOut,pipeLine : std_logic_vector(3 downto 0);
	signal instr_from_im : std_logic_vector(31 downto 0);
	signal MemRead, MemWrite,RegDst,Jump,Branch,branched,memToReg,ALUSrc, RegWrite, add_sub : std_logic;

	signal aluop : std_logic_vector (1 downto 0);
	signal zero2 : std_logic;
	--IF/ID--
	signal IF_ID_INS : std_logic_vector(31 downto 0);
	signal IF_ID_PC  : std_logic_vector(3 downto 0);
	--ID/EX--
	signal ID_EX_INS : std_logic_vector(31 downto 0);
	signal ID_EX_ALUSrc, ID_EX_RegDst,ID_EX_MemRead, ID_EX_Jump,ID_EX_Branch,ID_EX_MemWrite,ID_EX_MemToReg,ID_EX_RegWrite,Flush,Flush_RegWrite,Flush_Jump,Flush_Branch, Flush_MemWrite,jump_con: std_logic;
	signal ID_EX_ALUOp: std_logic_vector(2 downto 0);
	signal Op: std_logic_vector(2 downto 0);
	signal ID_EX_PC,ID_EX_Data1,ID_EX_Data2: std_logic_vector(3 downto 0);
	--EX/MEM--
	signal EX_MEM_jump,EX_MEM_branch,EX_MEM_zero,EX_MEM_RegWrite,EX_MEM_MemtoReg,EX_MEM_MemWrite: std_logic;
	signal EX_MEM_RegDestination,EX_MEM_WriteData,EX_MEM_Sum,EX_MEM_PC,EX_MEM_oldPC,EX_MEM_Jump_Address,ForwardA_Out,ForwardB_out: std_logic_vector(3 downto 0);
	--MEM/WB--
	signal MEM_WB_RegWrite,MEM_WB_MemtoReg: std_logic;
	signal MEM_WB_RegDestination,MEM_WB_Sum,MEM_WB_READ,dumbly: std_logic_vector(3 downto 0);
	--Forward
	signal ForwardA,ForwardB: std_logic_vector(1 downto 0);
begin
	pc_mux : mux2to1 generic map (n=>4) port map (reset, update_pc, initial_pc, mout);					--- multiplexer		--pc_new_jump in first slot for pipelining
	pc_mux2 : mux2to1 generic map (n=>4) port map (Flush, mout, rout, mout2);
	pc_Pipe : mux2to1 generic map (n=>4) port map (jump_con, mout2,pc_new_jump, pipeLine);
	pc	: regN generic map (n=>4) port map (clock, pipeLine, rout);												--- register
	---------- pc = pc +1 ------------------------------------------
	addpc : ripple_carry port map ('0', rout, "0001", update_pc);

	----------- IM -------------------------------------------------
	im : instruction_memory port map (clock, reset, rout, instr_from_im);
	
	
	
	-- Stage 1 -------------------------------------------------------
	
	------------- ID ------------------------------------------------
	id : instruction_decode port map (IF_ID_INS, MemRead, MemWrite, RegWrite, add_sub,RegDst,Jump,Branch,memToReg,ALUSrc, read_port1, read_port2, write_port,aluop);
	
	------------- RF --------------------------------------------------
	rf : register_file port map (clock, reset, MEM_WB_RegWrite, read_port1,read_port2, MEM_WB_RegDestination, regWriteOut, src1, src2);
	
	
	-- Stage 2 -------------------------------------------------------
	
	aluMux : mux2to1 generic map (n=>4) port map (ID_EX_ALUSrc,ID_EX_Data2 , ID_EX_INS( 3 downto 0), muxALU);	
	writePort : mux2to1 generic map (n=>4) port map (ID_EX_RegDst, ID_EX_INS( 19 downto 16), ID_EX_INS(14 downto 11), write_portMux);
	
	mux4to1_ForwardA	: mux4to1 generic map (n => 4) port map (ID_EX_Data1, EX_MEM_Sum,  regWriteOut, dumbly,ForwardA, ForwardA_Out);
	mux4to1_ForwardB	: mux4to1 generic map (n => 4) port map (muxALU     , EX_MEM_Sum , regWriteOut, dumbly,ForwardB, ForwardB_Out);
	
	alu_ins : alu port map (ForwardA_Out, ForwardB_Out,ID_EX_ALUOp(2),ID_EX_ALUOp(1 downto 0),zero2,sum);
	addBranch : ripple_carry port map ('0', ID_EX_PC, ID_EX_INS(3 downto 0), branch_update);
	
	jump_con<= '1' when branched ='1' or ID_EX_Jump = '1' else '0';
	branched<= EX_MEM_branch and EX_MEM_zero;
	BranchJump : mux2to1 generic map (n=>4) port map (ID_EX_Jump, pc_new , ID_EX_INS(3 downto 0), pc_new_jump);
	BranchMux : mux2to1 generic map (n=>4) port map (branched, ID_EX_PC , branch_update, pc_new);	
	
	-- Stage 3 -------------------------------------------------------
	
	------------- EM --------------------------------------------------
	Mem : mem_file port map (clock, reset, MemWrite, EX_MEM_Sum, EX_MEM_Sum, EX_MEM_WriteData, memOut);
	
	
	
	
	
	-- Stage 4 -------------------------------------------------------
	memMux : mux2to1 generic map (n=>4) port map (MEM_WB_MemtoReg, MEM_WB_Sum , MEM_WB_READ, regWriteOut);	
	
	
	
	Op(2)<=add_sub;
	Op(1 downto 0)<=aluop;
	--IF/ID--
	IF_ID_ins1 :  IF_ID port map(clock,reset,Flush,update_pc,instr_from_im,IF_ID_PC,IF_ID_INS);
	--ID/EX--
	--controls RegWrtie=0 Branch=0 Jump=0 MemWrite=0 Flush_RegWrite,Flush_Jump,Flush_Branch, Flush_MemWrite
		Flush_RegWrite <= RegWrite when Flush = '0' else '0';
		Flush_Branch<=Branch when Flush = '0' else '0';
		Flush_Jump<= Jump when Flush ='0' else '0';
		Flush_MemWrite<=MemWrite when Flush ='0' else '0';
	
	ID_EX_ins1 :  ID_EX port map(clock,reset,IF_ID_PC,src1,src2,Op,Flush_RegWrite,ALUSrc,RegDst,MemRead,Flush_Branch,Flush_Jump,Flush_MemWrite,memToReg,IF_ID_INS,ID_EX_PC,ID_EX_Data1,ID_EX_Data2,ID_EX_ALUOp,ID_EX_RegWrite,ID_EX_MemRead,ID_EX_ALUSrc,ID_EX_RegDst,ID_EX_Branch,ID_EX_Jump,ID_EX_MemWrite,ID_EX_MemToReg,ID_EX_INS);
	--EX/MEM--
	EX_MEM_ins1: EX_MEM port map(clock,reset,branch_update,ID_EX_INS(3 downto 0),ID_EX_PC,write_portMux,sum,ID_EX_Data2, ID_EX_RegWrite,ID_EX_Branch,ID_EX_Jump,ID_EX_MemWrite,ID_EX_MemToReg,zero2,EX_MEM_Sum,EX_MEM_PC,EX_MEM_RegDestination,EX_MEM_WriteData,EX_MEM_oldPC,EX_MEM_Jump_Address,EX_MEM_RegWrite,EX_MEM_branch,EX_MEM_jump,EX_MEM_MemWrite,EX_MEM_zero,EX_MEM_MemtoReg);
	--MEM/WB--
	MEM_WB_ins1: MEM_WB port map(clock,reset,memOut,EX_MEM_RegDestination,EX_MEM_Sum,EX_MEM_RegWrite,EX_MEM_MemtoReg,MEM_WB_RegDestination,MEM_WB_READ,MEM_WB_Sum,MEM_WB_RegWrite,MEM_WB_MemtoReg);		
	
	
	--Hazard--
	HazardUnits :  HazardUnit port map(ID_EX_MemRead,jump_con,ID_EX_INS( 19 downto 16),read_port1,read_port2,Flush);
	--Forward--
	Forward     :  Forwarding_Unit port map(EX_MEM_RegWrite,MEM_WB_RegWrite,MEM_WB_RegDestination,EX_MEM_RegDestination,ID_EX_INS(24 downto 21),ID_EX_INS(19 downto 16),ForwardA,ForwardB);

	current_pc <= rout;
	result <= MEM_WB_Sum;

end behaviour;
