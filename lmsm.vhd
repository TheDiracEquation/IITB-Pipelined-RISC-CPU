library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lmsm is
	port(
	immvalue : in std_logic_vector(15 downto 0);
	ravalue : in std_logic_vector(15 downto 0);
	rcvalue: in std_logic_vector(2 downto 0);
	immout : out std_logic_vector(15 downto 0);
	raout : out std_logic_vector(15 downto 0)
	);
end entity;

architecture archlmsm of lmsm is
	
	signal  imm, ra : std_logic_vector(15 downto 0);
	signal rc : std_logic_vector(2 downto 0);
	
	begin
		imm <= immvalue;
		ra <= ravalue;
		rc <= rcvalue;

		lmsmforward : process(imm,rc,ra)

	begin

		if(rc="000") then
			imm(7)<='0';
		elsif(rc="001") then
			imm(6)<='0';
		elsif(rc="010") then
			imm(5)<='0';
		elsif(rc="011") then
			imm(4)<='0';
		elsif(rc="100") then
			imm(3)<='0';
		elsif(rc="101") then
			imm(2)<='0';
		elsif(rc="110") then
			imm(1)<='0';
		elsif(rc="111") then
			imm(0)<='0';
		end if;
	ra <= ra or "0000000000000001";

	end process;

	immout <= imm;
	raout <= ra;

end archlmsm;