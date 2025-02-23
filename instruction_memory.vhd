---- This file describes the behavior of instruction memory ---------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.components.all;

entity instruction_memory is
	port(clock, reset : in std_logic;
			input : in std_logic_vector(3 downto 0);
			output : out std_logic_vector(31 downto 0));
end instruction_memory;

architecture struc_behaviour of instruction_memory is
	constant NOP : std_logic_vector(31 downto 0) := (others => '1');
	
	constant im0 : std_logic_vector(31 downto 0) := NOP;
	constant im1 : std_logic_vector(31 downto 0) := b"000000_00001_00011_00001_00000100000";
	constant im2 : std_logic_vector(31 downto 0) := b"000100_00000_00000_00000_00000000001";
	constant im3 : std_logic_vector(31 downto 0) := b"000000_00011_00001_00011_00000100000";
	constant im4 : std_logic_vector(31 downto 0) := b"000000_00001_00011_00011_00000100000";
	constant im5 : std_logic_vector(31 downto 0) := b"000100_00001_00000_00000_00000000001";
	constant im6 : std_logic_vector(31 downto 0) := b"000000_00001_00011_00011_00000100000";
	constant im7 : std_logic_vector(31 downto 0) := NOP;
	constant im8 : std_logic_vector(31 downto 0) := NOP;
	constant im9 : std_logic_vector(31 downto 0) := NOP;
	constant im10 : std_logic_vector(31 downto 0) := NOP;
	constant im11 : std_logic_vector(31 downto 0) := NOP;
	constant im12 : std_logic_vector(31 downto 0) := NOP;
	constant im13 : std_logic_vector(31 downto 0) := NOP;
	constant im14 : std_logic_vector(31 downto 0) := NOP;
	constant im15 : std_logic_vector(31 downto 0) := NOP;
	
	signal rout0, rout1, rout2, rout3, rout4, rout5, rout6, rout7, rout8, rout9, rout10, rout11, rout12, rout13, rout14, rout15 : std_logic_vector(31 downto 0);
	
	signal mout0, mout1, mout2, mout3, mout4, mout5, mout6, mout7, mout8, mout9, mout10, mout11, mout12, mout13, mout14, mout15 : std_logic_vector(31 downto 0);
   
	signal tri_state_enable : std_logic_vector(15 downto 0);
	
begin

	------------ decoder 4 x 16 to enable the tri-state buffer connected at the end of register -------------
	stage_dec : dec4to16 port map (input, '1', tri_state_enable);

	------------- location 0 -----------------------
	m0 : mux2to1 generic map (n=>32) port map (reset, rout0, im0, mout0);				--- multiplexer
	r0	: regN generic map (n=>32) port map (clock, mout0, rout0);							--- register
	tri0 : trin generic map (n=>32) port map (rout0, tri_state_enable(0), output);	--- tri-state buffer
	
	------------- location 1 -----------------------
	m1 : mux2to1 generic map (n=>32) port map (reset, rout1, im1, mout1);				--- multiplexer
	r1	: regN generic map (n=>32) port map (clock, mout1, rout1);							--- register
	tri1 : trin generic map (n=>32) port map (rout1, tri_state_enable(1), output);	--- tri-state buffer
	
	------------- location 2 -----------------------
	m2 : mux2to1 generic map (n=>32) port map (reset, rout2, im2, mout2);				--- multiplexer
	r2	: regN generic map (n=>32) port map (clock, mout2, rout2);							--- register
	tri2 : trin generic map (n=>32) port map (rout2, tri_state_enable(2), output);	--- tri-state buffer
	
	------------- location 3 -----------------------
	m3 : mux2to1 generic map (n=>32) port map (reset, rout3, im3, mout3);				--- multiplexer
	r3	: regN generic map (n=>32) port map (clock, mout3, rout3);							--- register
	tri3 : trin generic map (n=>32) port map (rout3, tri_state_enable(3), output);	--- tri-state buffer
	
	------------- location 4 -----------------------
	m4 : mux2to1 generic map (n=>32) port map (reset, rout4, im4, mout4);				--- multiplexer
	r4	: regN generic map (n=>32) port map (clock, mout4, rout4);							--- register
	tri4 : trin generic map (n=>32) port map (rout4, tri_state_enable(4), output);	--- tri-state buffer
	
	------------- location 5 -----------------------
	m5 : mux2to1 generic map (n=>32) port map (reset, rout5, im5, mout5);				--- multiplexer
	r5	: regN generic map (n=>32) port map (clock, mout5, rout5);							--- register
	tri5 : trin generic map (n=>32) port map (rout5, tri_state_enable(5), output);	--- tri-state buffer
	
	------------- location 6 -----------------------
	m6 : mux2to1 generic map (n=>32) port map (reset, rout6, im6, mout6);				--- multiplexer
	r6	: regN generic map (n=>32) port map (clock, mout6, rout6);							--- register
	tri6 : trin generic map (n=>32) port map (rout6, tri_state_enable(6), output);	--- tri-state buffer
	
	------------- location 7 -----------------------
	m7 : mux2to1 generic map (n=>32) port map (reset, rout7, im7, mout7);				--- multiplexer
	r7	: regN generic map (n=>32) port map (clock, mout7, rout7);							--- register
	tri7 : trin generic map (n=>32) port map (rout7, tri_state_enable(7), output);	--- tri-state buffer
	
	------------- location 8 -----------------------
	m8 : mux2to1 generic map (n=>32) port map (reset, rout8, im8, mout8);				--- multiplexer
	r8	: regN generic map (n=>32) port map (clock, mout8, rout8);							--- register
	tri8 : trin generic map (n=>32) port map (rout8, tri_state_enable(8), output);	--- tri-state buffer
	
	------------- location 9 -----------------------
	m9 : mux2to1 generic map (n=>32) port map (reset, rout9, im9, mout9);				--- multiplexer
	r9 : regN generic map (n=>32) port map (clock, mout9, rout9);							--- register
	tri9 : trin generic map (n=>32) port map (rout9, tri_state_enable(9), output);	--- tri-state buffer
	
	------------- location 10 -----------------------
	m10 : mux2to1 generic map (n=>32) port map (reset, rout10, im10, mout10);				--- multiplexer
	r10 : regN generic map (n=>32) port map (clock, mout10, rout10);							--- register
	tri10 : trin generic map (n=>32) port map (rout10, tri_state_enable(10), output);	--- tri-state buffer
	
	------------- location 11 -----------------------
	m11 : mux2to1 generic map (n=>32) port map (reset, rout11, im11, mout11);				--- multiplexer
	r11 : regN generic map (n=>32) port map (clock, mout11, rout11);							--- register
	tri11 : trin generic map (n=>32) port map (rout11, tri_state_enable(11), output);	--- tri-state buffer
	
	------------- location 12 -----------------------
	m12 : mux2to1 generic map (n=>32) port map (reset, rout12, im12, mout12);				--- multiplexer
	r12 : regN generic map (n=>32) port map (clock, mout12, rout12);							--- register
	tri12 : trin generic map (n=>32) port map (rout12, tri_state_enable(12), output);	--- tri-state buffer
	
	------------- location 13 -----------------------
	m13 : mux2to1 generic map (n=>32) port map (reset, rout13, im13, mout13);				--- multiplexer
	r13 : regN generic map (n=>32) port map (clock, mout13, rout13);							--- register
	tri13 : trin generic map (n=>32) port map (rout13, tri_state_enable(13), output);	--- tri-state buffer
	
	------------- location 14 -----------------------
	m14 : mux2to1 generic map (n=>32) port map (reset, rout14, im14, mout14);				--- multiplexer
	r14 : regN generic map (n=>32) port map (clock, mout14, rout14);							--- register
	tri14 : trin generic map (n=>32) port map (rout14, tri_state_enable(14), output);	--- tri-state buffer
	
	------------- location 15 -----------------------
	m15 : mux2to1 generic map (n=>32) port map (reset, rout15, im15, mout15);				--- multiplexer
	r15 : regN generic map (n=>32) port map (clock, mout15, rout15);							--- register
	tri15 : trin generic map (n=>32) port map (rout15, tri_state_enable(15), output);	--- tri-state buffer

end struc_behaviour;