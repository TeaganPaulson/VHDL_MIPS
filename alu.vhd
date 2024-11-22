-- Create a new VHDL file for ALU // it is the top level entity for the ALU

-- X, Y 				-- 4 bit input
-- add_sub			-- 1 bit input
-- ALUOP 			-- 2 bit input 
-- S					-- 4 bit output 
-- ZERO2 			-- 1 bit output


-- 3 stages to create this ALU. Use port Maps to do this 

-- Stage 1
-- ADD/SUb is the modified ripple carry adder from lab 2
-- 4X1 MUX to accomplish the ALU logic 
-- Write code for AND and OR for 4 bit 



-- Library definitions here 
library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

-- Entity declarations are specified here
entity alu is 

	port(
	
	X, Y:  in std_logic_vector(3 downto 0);
	add_sub: in std_logic;
	ALUOP: in std_logic_vector(1 downto 0);
	ZERO2: out std_logic;
	S : out std_logic_vector(3 downto 0));

end alu;



-- Architecture of the specified entity is created here

architecture alu_arch of alu is

signal sum_out, and_out, or_out,zero2_out : std_logic_vector( 3 downto 0);

begin
	
	--############### Creating instances for the outputs
	add_ins1 		: ripple_carry port map (add_sub, X, Y, sum_out);			--- adder output 
	and_ins1 		: and_gate generic map (n => 4) port map (X, Y, and_out);
	--- and output
	or_ins1  		: or_gate generic map (n => 4) port map (X, Y, or_out);		--- or output
	
	--############### Creating instances for overflow and underflow
	Mux2to1_ins1      : mux2to1 generic map (n => 4) port map (sum_out(3), "0000", "0001", zero2_out);	 --- overflow and underflow cases		
	

	----------         Creating instance for MUX4 to 1
	mux4to1_ins1	: mux4to1 generic map (n => 4) port map (zero2_out, sum_out, and_out, or_out, ALUOP, S);					--- multiplexer
	
	ZERO2 <= '1' when (sum_out="0000") else '0';
	
	
end alu_arch;
