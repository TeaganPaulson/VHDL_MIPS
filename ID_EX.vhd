-------- This is the 16 registers circuit for MIPS -----------------
library ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity ID_EX is
	port(clock, reset : in std_logic;
			PC_in, src1_in, src2_in : in std_logic_vector(3 downto 0);
			ALUOp : in std_logic_vector(2 downto 0);
			RegWrite,ALUsrc,RegDst,MemRead, branch,jump,MemWrite,memToReg : in std_logic;
			Instruct_in : in std_logic_vector(31 downto 0);
			PC_out,src1_out, src2_out : out std_logic_vector(3 downto 0);
			ALUOp_out : out std_logic_vector(2 downto 0);
			RegWrite_out,MemRead_Out,ALUsrc_out,RegDst_out, branch_out,jump_out,MemWrite_out,memToReg_out : out std_logic;
			Instruct_out : out std_logic_vector(31 downto 0));
end ID_EX;
	
architecture struc_behaviour of ID_EX is
	signal PC_reg, src1_reg,src2_reg : std_logic_vector(3 downto 0) :="0000";
	signal ALUOp_reg : std_logic_vector(2 downto 0) :="000";
	signal RegWrite_reg,ALUsrc_reg,RegDst_reg, branch_reg,jump_reg,MemWrite_reg,memToReg_reg,MemRead_reg : std_logic :='0';
	signal instruct_reg : std_logic_vector(31 downto 0) :="00000000000000000000000000000000";
begin

	process (clock)
	begin
		if clock'event and clock = '1' then
				if reset = '1' then
				PC_reg <= "0000";
				src1_reg<="0000";
				src2_reg<="0000";
				MemRead_Reg<='0';
				RegWrite_reg<='0';
				ALUsrc_reg<='0';
				RegDst_reg<='0';
				branch_reg<='0';
				jump_reg<='0';
				MemWrite_reg<='0';
				memToReg_reg<='0';
				ALUOp_reg<="000";
				Instruct_reg<="00000000000000000000000000000000";
				
				else
				PC_reg <= PC_in;
				Instruct_reg<=Instruct_in;
				src1_reg<=src1_in;
				src2_reg<=src2_in;
				RegWrite_reg<=RegWrite;
				ALUsrc_reg<=ALUsrc;
				RegDst_reg<=RegDst;
				branch_reg<=branch;
				jump_reg<=jump;
				ALUOp_reg<=ALUOp;
				MemWrite_reg<=MemWrite;
				memToReg_reg<=memToReg;
				MemRead_reg<=MemRead;
				end if;
		end if;
	end process;
	MemRead_Out<=MemRead_reg;
	MemWrite_out<=MemWrite_reg;
	memToReg_out<=memToReg_reg;
	PC_out<=PC_reg;
	src1_out<=src1_reg;
	src2_out<=src2_reg;
	ALUOp_out<=ALUOp_reg;
	RegWrite_out<=RegWrite_reg;
	ALUsrc_out<=ALUsrc_reg;
	RegDst_out<=RegDst_reg;
	branch_out<=branch_reg;
	jump_out<=jump_reg;
	Instruct_out<=instruct_reg;
end struc_behaviour;