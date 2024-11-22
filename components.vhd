library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

package components is

---------Created for lab 3 --------------------
------------ alu logic ---------------
component alu is 
	port(
	X, Y:  in std_logic_vector(3 downto 0);
	add_sub: in std_logic;
	ALUOP: in std_logic_vector(1 downto 0);
	ZERO2: out std_logic;
	S : out std_logic_vector(3 downto 0));
end component;

------------ n bit AND ---------------
component and_gate IS
	generic(n : integer := 4);
	port(
	A, B:  in std_logic_vector((n-1) downto 0);
	C : out std_logic_vector((n-1) downto 0));
END component;
------------ n bit OR ---------------
component or_gate IS
	generic(n : integer := 4);
	port(
	A, B:  in std_logic_vector((n-1) downto 0);
	C : out std_logic_vector((n-1) downto 0));
END component;

------------ full adder ---------------
component fulladd IS
	PORT ( Cin, x, y : IN STD_LOGIC;
		s, Cout : OUT STD_LOGIC );
END component;

------------- n stage ripple carry adder -------------------
component ripple_carry IS
	PORT ( Cin: IN STD_LOGIC;
			x,y : IN STD_LOGIC_VECTOR(3 downto 0);
			s : OUT STD_LOGIC_VECTOR(3 downto 0);
			Cout : OUT STD_LOGIC );
END component;

--------- multiplexer -----------------------
component mux2to1 IS
	generic(n : integer := 4);
	PORT ( s : IN std_logic;
			a, b : in std_logic_vector((n-1) downto 0);
			f : OUT std_logic_vector((n-1) downto 0));
END component;

component mux4to1 IS
	generic  (n : integer:= 4);
	PORT ( w0, w1, w2, w3 : IN STD_LOGIC_VECTOR((n-1) downto 0);
		s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		f : OUT STD_LOGIC_VECTOR((n-1) downto 0));
END component;

---------------- decoders -------------------------
component dec2to4 IS
	PORT ( w : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			En : IN STD_LOGIC;
			y : OUT STD_LOGIC_VECTOR(3 downto 0));
END component;

component dec4to16 IS
	PORT (w : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			En : IN STD_LOGIC;
			y : OUT STD_LOGIC_VECTOR(15 downto 0));
END component;

------------- n stage tri-state buffer ------------------------
component trin IS
	GENERIC (N : INTEGER := 8);
	PORT (X : IN STD_LOGIC_VECTOR((N-1) DOWNTO 0);
			E : IN STD_LOGIC;
			F : OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0));
END component;

------------ n bit register -----------------------
component regN is
	generic(N: integer:= 32);
	port (clock : in std_logic;
	  D : in std_logic_vector(N-1 downto 0);
	  Q : out std_logic_vector(N-1 downto 0));
end component;

-------------- instruction memeory --------------------------
component instruction_memory is
	port(clock, reset : in std_logic;
			input : in std_logic_vector(3 downto 0);
			output : out std_logic_vector(31 downto 0));
end component;

--------------- register file -------------------------------
component register_file is
	port(clock, reset, RegWrite : in std_logic;
			read_port1, read_port2, write_port, write_value : in std_logic_vector(3 downto 0);
			value1, value2 : out std_logic_vector(3 downto 0));
end component;
--------------- mem file -------------------------------
component mem_file is
	port(clock, reset, RegWrite : in std_logic;
			read_port1, write_port, write_value : in std_logic_vector(3 downto 0);
			value1 : out std_logic_vector(3 downto 0));
end component;

------------- instrcution decode ----------------------------
component instruction_decode is
	port(instr : in std_logic_vector(31 downto 0);
			MemRead, MemWrite, RegWrite, add_sub,RegDst,Jump,Branch,memToReg,ALUSrc : out std_logic;
			read_p1, read_p2, write_p : out std_logic_vector(3 downto 0);
			aluop : out std_logic_vector (1 downto 0));
end component;

Component IF_ID is
	port(clock, reset, stall: in std_logic;
			PC_in : in std_logic_vector(3 downto 0);
			Instruct_in : in std_logic_vector(31 downto 0);
			PC_out : out std_logic_vector(3 downto 0);
			Instruct_out : out std_logic_vector(31 downto 0));
end component;

component ID_EX is
	port(clock, reset : in std_logic;
			PC_in, src1_in, src2_in : in std_logic_vector(3 downto 0);
			ALUOp : in std_logic_vector(2 downto 0);
			RegWrite,ALUsrc,RegDst,MemRead, branch,jump,MemWrite,memToReg : in std_logic;
			Instruct_in : in std_logic_vector(31 downto 0);
			PC_out,src1_out, src2_out : out std_logic_vector(3 downto 0);
			ALUOp_out : out std_logic_vector(2 downto 0);
			RegWrite_out,MemRead_Out,ALUsrc_out,RegDst_out, branch_out,jump_out,MemWrite_out,memToReg_out : out std_logic;
			Instruct_out : out std_logic_vector(31 downto 0));
end component;

component EX_MEM is
	port(clock, reset : in std_logic;
			PC_in,jump_address,old_pc,Write_Destination,sum,writeData: in std_logic_vector(3 downto 0);
			RegWrite,branch,jump,MemWrite,memToReg, zero : in std_logic;
			sum_out,PC_out,Write_Destination_out,writeData_out,old_pc_out,jump_address_out : out std_logic_vector(3 downto 0);
			RegWrite_out, branch_out,jump_out,MemWrite_out, zero_out, memToReg_out: out std_logic);
end component;

component MEM_WB is
	port(clock, reset : in std_logic;
			Data1,Write_Destination,Data2: in std_logic_vector(3 downto 0);
			RegWrite,memToReg : in std_logic;
			Write_Destination_out,Data1_out,Data2_out : out std_logic_vector(3 downto 0);
			RegWrite_out,memToReg_out : out std_logic);
end component;

component Forwarding_Unit is
	port( EX_MEM_RegWrite,MEM_WB_RegWrite: std_logic;
			MEM_WB_RegisterRd, EX_MEM_Register_Rd, ID_EX_RegisterRs, ID_EX_RegisterRt: in std_logic_vector(3 downto 0);
			ForwardA, ForwardB : out std_logic_vector(1 downto 0));
end component;
component HazardUnit is
	port( ID_EX_MemRead, Branched: std_logic;
			ID_EX_RegisterRt, IF_ID_RegisterRs, IF_ID_RegisterRt : in std_logic_vector(3 downto 0);
			Stall: out std_logic);
end component;

end components;