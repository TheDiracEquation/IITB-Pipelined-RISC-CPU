library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity em is
port(clk,reset,writevalue : in std_logic;
	alu_outip, pc_in: in std_logic_vector(15 downto 0);
	rc_add_in: in std_logic_vector(2 downto 0);
	ra_data_in: in std_logic_vector(15 downto 0);
	z_in,c_in: in std_logic;
	cond_in: in std_logic_vector(1 downto 0);
	opcode_in: in std_logic_vector(3 downto 0);
--	flipin: in std_logic;
	alu_outop, pc_op: out std_logic_vector(15 downto 0);
	rc_add_op: out std_logic_vector(2 downto 0);
	ra_data_op: out std_logic_vector(15 downto 0);
	z_op,c_op: out std_logic;
	cond_op: out std_logic_vector(1 downto 0);
	opcode_op: out std_logic_vector(3 downto 0);
					controlsigin : in std_logic_vector(7 downto 0);
				controlsigout : out std_logic_vector(7 downto 0));

--	flipout: out std_logic);
end entity;

architecture exec_mem of em is

signal alu_out, pc, ra_data: std_logic_vector(15 downto 0);
signal z, c: std_logic;
signal cond: std_logic_vector(1 downto 0);
signal opcode: std_logic_vector(3 downto 0);
signal rc_add: std_logic_vector(2 downto 0);
	signal controlsig: std_logic_vector(7 downto 0);
begin

store_proc : process(writevalue,alu_outip,z_in,c_in,opcode_in,pc_in,ra_data_in,rc_add_in,cond_in,controlsigin)
begin
	if(writevalue='1') then
		alu_out<=alu_outip;
		z<=z_in;
		c<=c_in;
		opcode<=opcode_in;
		pc<=pc_in;
		ra_data<=ra_data_in;
		rc_add<=rc_add_in;
		cond<=cond_in;
--		flip<=flipin;
	controlsig <= controlsigin;
	end if;
end process;

write_proc: process(clk,reset,alu_out,pc,ra_data,z,c,cond,opcode,rc_add,controlsig)
begin
	if(reset='1') then
		pc_op <= "0000000000000000";
		opcode_op <= "0000";
		ra_data_op <= "0000000000000000";
		cond_op <= "00";
        alu_outop <= "0000000000000000";
        rc_add_op <= "000";
        c_op <= '0';
        z_op <= '0';
		  					controlsigout <= "00000000";
--        flipout <= '0';
    elsif(clk'event and clk = '0') then
    	alu_outop<=alu_out;
		z_op<=z;
		c_op<=c;
		opcode_op<=opcode;
		pc_op<=pc;
		ra_data_op<=ra_data;
		rc_add_op<=rc_add;
		cond_op<=cond;
--		flipout<=flip;
controlsigout <= controlsig;
	end if;
end process;

end architecture;
