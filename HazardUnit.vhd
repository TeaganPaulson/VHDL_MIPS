-------- This is the 16 registers circuit for MIPS -----------------
library ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity HazardUnit is
	port( ID_EX_MemRead,Branched: std_logic;
			ID_EX_RegisterRt, IF_ID_RegisterRs, IF_ID_RegisterRt : in std_logic_vector(3 downto 0);
			Stall: out std_logic);
end HazardUnit;

architecture struc_behaviour of HazardUnit is
begin
	Stall <='1' when ((ID_EX_MemRead = '1' and ((ID_EX_RegisterRt = IF_ID_RegisterRs) or (ID_EX_RegisterRt = IF_ID_RegisterRt))) or (Branched = '1')) else '0';
	

end struc_behaviour;