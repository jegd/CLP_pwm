	library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm is
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
end;
		
architecture pwm_arq of pwm is 
-- Parte declarativa
component contBCD is
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		num_maxi: in std_logic_vector(31 downto 0);
		cuenta_o: out std_logic_vector(31 downto 0);
		max_o: out std_logic
	);
end component;	
constant n_ciclos_on :integer := 3;
signal salBCD : std_logic_vector(31 downto 0);
signal maximo : std_logic;
--variable count_i: integer range 0 to 16 := 5;
begin
	
-- Parte descriptiva
contBCD_inst: contBCD
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			num_maxi => duty_i,
			cuenta_o  => salBCD,
			max_o   => maximo
		);
		cuenta_o<= salBCD;
		process(clk_i)
		begin
		if rising_edge(clk_i) then
			if to_integer(unsigned(salBCD)) >= n_ciclos_on then
				pwm_o <= '1';
				elsif to_integer(unsigned(salBCD)) < n_ciclos_on then
					pwm_o <= '0';
			end if ;
		end if ;
		end process;
end;