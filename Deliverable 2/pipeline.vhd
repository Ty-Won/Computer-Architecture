library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
end pipeline;


architecture behavioral of pipeline is

signal async_op1 : integer := 0;
signal async_op2 : integer := 0;
signal async_op3 : integer := 0;
signal async_op4 : integer := 0;
signal async_op5 : integer := 0;


begin
-- todo: complete this
process (clk)
begin
  if rising_edge(clk) then
	--calculate final output based on prev async op2 and op5
	final_output <= async_op2 - async_op5;

	-- calculate new op2
	op2 <= async_op1 * 42;
	async_op2 <= async_op1 * 42;

	-- calculate new op5
	op5 <= async_op3 * async_op4;
	async_op5 <= async_op3 * async_op4;

	-- Process new inputs
      	op1 <= a + b;
	op3 <= c*d;
        op4 <= a-e;

	-- store outputs for next cycle
	async_op1 <= a+b;
	async_op3 <= c*d;
	async_op4 <= a-e;
  end if;
    

end process;

end behavioral;