library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm_tb is
end;
		
architecture pwm_tb_arq of pwm_tb is 
-- Parte declarativa
      component pwm is
		generic(
			A: REAL := 0.5;
			V: natural :=4
		);
		port(
			clk_i: in std_logic;
			rst_i: in std_logic;
			ena_i: in std_logic;
			duty_i: in std_logic_vector(31 downto 0);
			cuenta_o: out std_logic_vector(31 downto 0);
			pwm_o: out std_logic
		);
	   end component;
  	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '1';
	signal ena_tb: std_logic := '1';
	signal duty_tb: std_logic_vector(31 downto 0);
	signal cuenta_tb:std_logic_vector(31 downto 0);
	signal pwm_tb: std_logic:= '0';
	
begin
-- Parte descriptiva
clk_tb <= not clk_tb after 10 ns;
rst_tb <= '0' after 30 ns;
ena_tb <= '0' after 20 ns, '1' after 30 ns;
duty_tb<= std_logic_vector(to_unsigned(9,32));	
	
	DUT: pwm
		  port map(
			clk_i => clk_tb,
			rst_i => rst_tb,
			ena_i => ena_tb,
			duty_i => duty_tb,
			cuenta_o =>cuenta_tb,
			pwm_o => pwm_tb
		  );
end;