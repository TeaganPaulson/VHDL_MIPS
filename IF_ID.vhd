-------- This is the 16 registers circuit for MIPS -----------------
library ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity IF_ID is
	port(clock, reset,stall : in std_logic;
			PC_in : in std_logic_vector(3 downto 0);
			Instruct_in : in std_logic_vector(31 downto 0);
			PC_out : out std_logic_vector(3 downto 0);
			Instruct_out : out std_logic_vector(31 downto 0));
end IF_ID;
	
architecture struc_behaviour of IF_ID is
	signal PC_reg : std_logic_vector(3 downto 0) :="0000";
	signal instruct_reg : std_logic_vector(31 downto 0) :="00000000000000000000000000000000";
begin
	process (clock)
	begin
		if clock'event and clock = '1' and stall = '0' then
				if reset = '1' then
				PC_reg <= "0000";
				Instruct_reg<="00000000000000000000000000000000";
				else
				PC_reg <= PC_in;
				Instruct_reg<=Instruct_in;
				end if;
		end if;
	end process;
	PC_out<=PC_reg;
	Instruct_out<=instruct_reg;
end struc_behaviour;