library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contBCD is
	generic(
		N: natural := 32
	);
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		num_maxi: in std_logic_vector(N-1 downto 0);
		cuenta_o: out std_logic_vector(N-1 downto 0);
		max_o: out std_logic
	);
end;	
	
architecture contBCD_arq of contBCD is
-- Parte declarativa
component reg is
	generic(
		N: natural := 32
	);

	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		d_i: in std_logic_vector(N-1 downto 0);
		q_o: out std_logic_vector(N-1 downto 0)
	);
end component;

	signal salAnd, salOr, salComp: std_logic;
	signal salReg, copiaReg,salSum : std_logic_vector(31 downto 0);

begin
-- Parte descriptiva
	salOr <= rst_i or salAnd;
	salAnd <= ena_i and salComp;
	salSum <= std_logic_vector(unsigned(salReg) + "0001");
	copiaReg <= salReg;

	max_o <= salComp;
	reg_inst: reg
	generic map(
	N => 32
	)
	port map(
		clk_i => clk_i,
		rst_i => salOr,
		ena_i => ena_i,
		d_i   => salSum,
		q_o   => salReg
	);

	cuenta_o <= salReg;

	process(clk_i)
	begin
	if rising_edge(clk_i) then
		if to_integer(unsigned(salReg)) = (to_integer(unsigned(num_maxi))-2) then
			salComp <= '1';
		else
			salComp <= '0';
		end if ;
	end if ;
	end process;
end;