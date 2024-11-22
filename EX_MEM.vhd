-------- This is the 16 registers circuit for MIPS -----------------
library ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity EX_MEM is
	port(clock, reset : in std_logic;
			PC_in,jump_address,old_pc,Write_Destination,sum,writeData: in std_logic_vector(3 downto 0);
			RegWrite,branch,jump,MemWrite,memToReg, zero : in std_logic;
			sum_out,PC_out,Write_Destination_out,writeData_out,old_pc_out,jump_address_out : out std_logic_vector(3 downto 0);
			RegWrite_out, branch_out,jump_out,MemWrite_out, zero_out, memToReg_out: out std_logic);
end EX_MEM;
	
architecture struc_behaviour of EX_MEM is
	signal PC_reg, src1_reg,src2_reg,Write_Destination_reg,writeData_reg,jump_address_reg,old_pc_reg,sum_reg : std_logic_vector(3 downto 0) :="0000";
	signal Write_reg : std_logic_vector(3 downto 0) :="0000";
	signal ALUOp_reg : std_logic_vector(2 downto 0) :="000";
	signal RegWrite_reg,ALUsrc_reg,RegDst_reg, branch_reg,jump_reg,MemRead_reg,MemWrite_reg,zero_reg,memToReg_reg : std_logic :='0';
	signal instruct_reg : std_logic_vector(31 downto 0) :="00000000000000000000000000000000";
begin
	

	process (clock)
	begin
		if clock'event and clock = '1' then
				if reset = '1' then
				PC_reg <= "0000";
				writeData_reg<="0000";
				jump_address_reg<="0000";
				RegWrite_reg<='0';
				branch_reg<='0';
				jump_reg<='0';
				MemRead_reg<='0';
				memToReg_reg<='0';
				zero_reg<='0';
				Write_Destination_reg<="0000";
				old_pc_reg<="0000";
				sum_reg<="0000";
				else
				old_pc_reg<=old_pc;
				PC_reg <= PC_in;
				RegWrite_reg<=RegWrite;
				branch_reg<=branch;
				jump_reg<=jump;
				MemWrite_reg<=MemWrite;
				zero_reg<=zero;
				Write_Destination_reg<=Write_Destination;
				writeData_reg<=writeData;
				memToReg_reg<=memToReg;
				jump_address_reg<=jump_address;
				sum_reg<=sum;
				end if;
		end if;
	end process;
	sum_out<=sum_reg;
	old_pc_out<=old_pc_reg;
	jump_address_out<=jump_address_reg;
	MemWrite_out<=MemWrite_Reg;
	PC_out<=PC_reg;
	RegWrite_out<=RegWrite_reg;
	branch_out<=branch_reg;
	jump_out<=jump_reg;
	zero_out<=zero_reg;
	Write_Destination_out<=Write_Destination_reg;
	writeData_out<=writeData_reg;
	memToReg_out<=memToReg_reg;
end struc_behaviour;