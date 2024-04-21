library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contBCD_tb is
end;
architecture contBCD_tb_arq of contBCD_tb is
component contBCD is
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		cuenta_o: out std_logic_vector(3 downto 0);
		max_o: out std_logic
	);
end component;	
	
	signal clk_tb: std_logic:= '0';
	signal rst_tb: std_logic:= '1';
	signal ena_tb: std_logic:= '1';
	signal cuenta_tb: std_logic_vector(3 downto 0);
	signal max_tb: std_logic;

begin
-- Parte descriptiva
	
	clk_tb <= not clk_tb after 20 ns;
	rst_tb <= '0' after 50 ns;
	ena_tb <= '0' after 150 ns, '1' after 200 ns;	

	DUT: contBCD
		port map(
		clk_i => clk_tb,
		rst_i => rst_tb,
		ena_i => ena_tb,
		cuenta_o => cuenta_tb,
		max_o => max_tb
		);
end;