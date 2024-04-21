library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contBCD is
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		cuenta_o: out std_logic_vector(3 downto 0);
		max_o: out std_logic
	);
end;	
	
architecture contBCD_arq of contBCD is
-- Parte declarativa
component reg is
	generic(
		N: natural := 4
	);

	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		d_i: in std_logic_vector(N-1 downto 0);
		q_o: out std_logic_vector(N-1 downto 0)
	);
end component;

	signal salReg, salSum: std_logic_vector(3 downto 0);
	signal salAnd, salOr, salComp: std_logic;

begin
-- Parte descriptiva
	salOr <= rst_i or salAnd;
	salAnd <= ena_i and salComp;
	salSum <= std_logic_vector(unsigned(salReg) + "0001");
	salComp <= salReg(3) and not salReg(2) and not salReg(1) and salReg(0);
	max_o <= salComp;
	reg_inst: reg
	generic map(
	N => 4
	)
	port map(
		clk_i => clk_i,
		rst_i => salOr,
		ena_i => ena_i,
		d_i   => salSum,
		q_o   => salReg
	);

	cuenta_o <= salReg;
end;