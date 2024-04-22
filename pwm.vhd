library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm is
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
end;
		
architecture pwm_arq of pwm is 
-- Parte declarativa
component contBCD is
	generic(
		N: natural := 32
	);
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		num_maxi: in std_logic_vector(31 downto 0);
		cuenta_o: out std_logic_vector(31 downto 0);
		max_o: out std_logic
	);
end component;	
signal n_ciclos_on :integer := 10;
signal salBCD,n_ciclos : std_logic_vector(31 downto 0);
signal maximo : std_logic;
signal aux1: integer :=0;

--variable count_i: integer range 0 to 16 := 5;
begin
n_ciclos<=  std_logic_vector(to_unsigned(aux1,32));
n_ciclos_on<= (to_integer(unsigned(n_ciclos))*to_integer(unsigned(duty_i)))/100;
contBCD_inst: contBCD
		generic map(
			N=> 32
		)
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			num_maxi => n_ciclos,
			cuenta_o  => salBCD,
			max_o   => maximo
		);
		process(clk_i)
		begin
		if rising_edge(clk_i) then
		aux1<= 200000000/to_integer(unsigned(freq_i));
			if to_integer(unsigned(salBCD)) >= n_ciclos_on then
				pwm_o <= '0';
				elsif to_integer(unsigned(salBCD)) < n_ciclos_on then
					pwm_o <= '1';
			end if ;
		end if ;
		end process;
end;