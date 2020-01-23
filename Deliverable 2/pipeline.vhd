library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
end pipeline;

--!
op1 is the intermediate result of a + b
op2 is the intermediate result of op1 * 42
op3 is the intermediate result of c * d
op4 is the intermediate result of a – e
op5 is the intermediate result of op3 * op4
final_output is the result of op2 – op5
--!

architecture behavioral of pipeline is

signal prev_a : integer;
signal prev_b : integer;
signal prev_c : integer;
signal prev_d : integer;
signal prev_e : integer;


signal async_op1 : integer;
signal async_op2 : integer;
signal async_op3 : integer;
signal async_op4 : integer;
signal async_op5 : integer;

signal change_in_input: boolean;

begin
-- todo: complete this
process (clk)
begin
  if rising_edge(clk) then
    if (a /= prev_a or b /= prev_b or e/=prev_e) then
      async_op1 <= op1;
      op1 <= a + b;
      if a/=prev_a or e/=prev_e then:
        async_op4 <= op4;
        op4 <= a-e;
      end if;
    end if;
    if c /= prev_c or d /= prev_d then:
      async_op3 <= op3;
      op3 <= c*d;
    end if;
  end if;
    

end process;

end behavioral;