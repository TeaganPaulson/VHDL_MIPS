-------- This is the 16 registers circuit for MIPS -----------------
library ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity Forwarding_Unit is
	port( EX_MEM_RegWrite,MEM_WB_RegWrite: std_logic;
			MEM_WB_RegisterRd, EX_MEM_Register_Rd, ID_EX_RegisterRs, ID_EX_RegisterRt: in std_logic_vector(3 downto 0);
			ForwardA, ForwardB : out std_logic_vector(1 downto 0));
end Forwarding_Unit;

architecture struc_behaviour of Forwarding_Unit is
signal ex,mem : std_logic_vector(3 downto 0);
begin
	
	ForwardA<="01" when (EX_MEM_RegWrite='1' and (EX_MEM_Register_Rd /= "0000") and (EX_MEM_Register_Rd = ID_EX_RegisterRs)) else 
				 "10" when (MEM_WB_RegWrite='1' and (MEM_WB_RegisterRd /= "0000") and (MEM_WB_RegisterRd = ID_EX_RegisterRs)) else
				 "00";
	ForwardB<="01" when (EX_MEM_RegWrite='1' and (EX_MEM_Register_Rd /= "0000") and (EX_MEM_Register_Rd = ID_EX_RegisterRt)) else 
				 "10" when (MEM_WB_RegWrite='1' and (MEM_WB_RegisterRd /= "0000") and (MEM_WB_RegisterRd = ID_EX_RegisterRt)) else
				 "00";
end struc_behaviour;