library ieee;
use ieee.std_logic_1164.all;
-- The following code is for the stage 2 of the pipeline, it contains a 16 bit instruction
-- register and a 16 bit signal for transferring pc.

entity stage2 is
 
	port(
		clk,rst : in std_logic;
		pcin : in std_logic_vector(15 downto 0);
		IRip : in std_logic_vector(15 downto 0);
		IR15_12 : out std_logic_vector(3 downto 0);
		IR11_9 : out std_logic_vector(2 downto 0);
		IR8_6 : out std_logic_vector(2 downto 0);
		IR5_3 : out std_logic_vector(2 downto 0);
		IR5_0 : out std_logic_vector(15 downto 0);
		IR8_0 : out std_logic_vector(15 downto 0);
		IR1_0 : out std_logic_vector(1 downto 0);
		IR_c : out std_logic;
		pcout : out std_logic_vector(15 downto 0);
		controlsigout :  out std_logic_vector(7 downto 0)
	);
end entity;

architecture stage2arch of stage2 is

	component extend_6_16 is
	port(input: in std_logic_vector(5 downto 0);
	     output: out std_logic_vector(15 downto 0));
   end component;

   component extend_9_16 is
	port(input: in std_logic_vector(8 downto 0);
		  output: out std_logic_vector(15 downto 0));
   end component;
		  
	component zeroextender is
	port(input: in std_logic_vector(8 downto 0);
		  output: out std_logic_vector(15 downto 0));
        end component;
		  
	component control is
	port(
			opcode: in std_logic_vector(3 downto 0);
			enabler: out std_logic_vector(7 downto 0));
		end component;
	
	signal ext9imm,ext6imm, extzero: std_logic_vector(15 downto 0);
	signal controlsig : std_logic_vector(7 downto 0);
	
begin
	extend9imm : extend_9_16 port map(input => IRip(8 downto 0), output => ext9imm);--extending immedaite values to 15 bits
	extend6imm : extend_6_16 port map(input => IRip(5 downto 0), output => ext6imm);
	extendzero : zeroextender port map(input => IRip(8 downto 0), output => extzero);
	controller: control port map(opcode => IRip(15 downto 12), enabler => controlsig);	
	stage2work: process(IRip,pcin,extzero,ext6imm,ext9imm)
	
	begin
	
	IR15_12 <= IRip(15 downto 12);
	IR11_9 <= IRip(11 downto 9);
	IR8_6 <= IRip(8 downto 6);
	IR5_3 <= IRip(5 downto 3);
	IR1_0 <= IRip(1 downto 0); 
	pcout <= pcin;
	IR_c <= IRip(2);
	
	if(IRip(15 downto 12)="0011") then
		IR8_0 <= extzero;
		IR5_0 <= ext6imm;
	else 
		IR8_0 <= ext9imm;
		IR5_0 <= ext6imm;
	
	end if;
end process;
controlsigout <= controlsig;
end stage2arch;

		
		