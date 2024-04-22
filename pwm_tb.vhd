library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm_tb is
end;
		
architecture pwm_tb_arq of pwm_tb is 
-- Parte declarativa
      component pwm is
		generic(
			N: natural :=32
		);
		port(
			clk_i: in std_logic;
			rst_i: in std_logic;
			ena_i: in std_logic;
			freq_i: in std_logic_vector(N-1 downto 0);
			duty_i: in std_logic_vector(N-1 downto 0);
			pwm_o: out std_logic
		);
	   end component;
  	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '1';
	signal ena_tb: std_logic := '1';
	signal freq_tb: std_logic_vector(31 downto 0);
	signal duty_tb :std_logic_vector(31 downto 0);
	signal pwm_tb: std_logic:= '0';
	
begin
-- Parte descriptiva
clk_tb <= not clk_tb after 10 ns;
rst_tb <= '0' after 30 ns;
ena_tb <= '0' after 20 ns, '1' after 30 ns;
freq_tb<= std_logic_vector(to_unsigned(20,32));
duty_tb<= std_logic_vector(to_unsigned(90,32));

	DUT: pwm
			generic map(
				N=>32
			)
		  port map(
			clk_i => clk_tb,
			rst_i => rst_tb,
			ena_i => ena_tb,
			freq_i => freq_tb,
			duty_i => duty_tb,
			pwm_o => pwm_tb
		  );
end;