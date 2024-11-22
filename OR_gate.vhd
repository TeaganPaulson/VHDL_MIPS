-- creating the AND logic for the ALU n bit generic 
-- A, B	: n bit input
-- C		: n bit output

-- library definitions here  
library ieee;
use ieee.std_logic_1164.all;

-- Entity declarations are specified here
entity OR_gate is 
	generic(n : integer := 4);
	port(
	A, B:  in std_logic_vector((n-1) downto 0);
	C : out std_logic_vector((n-1) downto 0));
end OR_gate;
-- Architecture of the specified entity is created here
architecture AND_arch of OR_gate is

begin 
	--process(a,b)
		--begin 
			C <= A OR B;
		--end process;	
end AND_arch;
-- EOF