library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm_prueba is
	generic(
		A: REAL := 0.5;
		V: natural :=4
	);
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		duty_o: in std_logic_vector(V-1 downto 0);
		cuenta_prueba_o: out std_logic_vector(3 downto 0);
		pwm_prueba_o: out std_logic
	);
end;
		
architecture pwm_prueba_arq of pwm_prueba is 
-- Parte declarativa
component contBCD is
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		cuenta_o: out std_logic_vector(3 downto 0);
		max_o: out std_logic
	);
end component;	
constant n_ciclos_on :integer := 5;
signal salBCD : std_logic_vector(3 downto 0);
signal dutyy : std_logic_vector(4 downto 0);
signal maximo,comparacion,comparacion_0, pwm_prueba_salida : std_logic;
--variable count_i: integer range 0 to 16 := 5;
begin
	--comparacion <=  to_integer(unsigned(salBCD)) and n_ciclos_on;
	comparacion_0 <=  not salBCD(3) and not salBCD(2) and not salBCD(1) and not salBCD(0);
	--duty_o<= "1111";
-- Parte descriptiva
contBCD_inst: contBCD
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			cuenta_o  => cuenta_prueba_o,
			max_o   => pwm_prueba_o
		);
	
end;