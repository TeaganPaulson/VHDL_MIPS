-------- This is the 16 registers circuit for MIPS -----------------
library ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity MEM_WB is
	port(clock, reset : in std_logic;
			Data1,Write_Destination,Data2: in std_logic_vector(3 downto 0);
			RegWrite,memToReg : in std_logic;
			Write_Destination_out,Data1_out,Data2_out : out std_logic_vector(3 downto 0);
			RegWrite_out,memToReg_out : out std_logic);
end MEM_WB;

architecture struc_behaviour of MEM_WB is
	signal data1_reg,data2_reg,Write_Destination_reg : std_logic_vector(3 downto 0) :="0000";
	signal RegWrite_reg,memToReg_reg : std_logic :='0';
begin
	process (clock)
	begin
		if clock'event and clock = '1' then
				if reset = '1' then
				RegWrite_reg<='0';
				memToReg_reg<='0';
				Write_Destination_reg<="0000";
				data1_reg<="0000";
				data2_reg<="0000";
				else
				RegWrite_reg<=RegWrite;
				Write_Destination_reg<=Write_Destination;
				memToReg_reg<=memToReg;
				data1_reg<=data1;
				data2_reg<=data2;
				end if;

		end if;
	end process;
	RegWrite_out<=RegWrite_reg;
	Write_Destination_out<=Write_Destination_reg;
	memToReg_out<=memToReg_reg;
	data1_out<=data1_reg;
	data2_out<=data2_reg;
end struc_behaviour;